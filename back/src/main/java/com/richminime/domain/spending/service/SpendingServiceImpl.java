package com.richminime.domain.spending.service;

import com.richminime.domain.spending.constatnt.SpendingCategoryEnums;
import com.richminime.domain.spending.constatnt.TimeEnums;
import com.richminime.domain.spending.domain.DaySpendingPattern;
import com.richminime.domain.spending.domain.MonthSpendingPattern;
import com.richminime.domain.spending.domain.Spending;
import com.richminime.domain.spending.dto.response.FindDaySpendingResDto;
import com.richminime.domain.spending.dto.response.FindMonthSpendingResDto;
import com.richminime.domain.spending.dto.response.SpendingDto;
import com.richminime.domain.spending.repository.DaySpendingPatternRedisRepository;
import com.richminime.domain.spending.repository.MonthSpendingPatternRedisRepository;
import com.richminime.domain.spending.repository.SpendingRepository;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.exception.UserExceptionMessage;
import com.richminime.domain.user.exception.UserNotFoundException;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.common.codef.CodefWebClient;
import com.richminime.global.common.codef.dto.request.FindSpendingListReqDto;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional
public class SpendingServiceImpl implements SpendingService {

    private final SpendingRepository spendingRepository;
    private final UserRepository userRepository;
    private final CodefWebClient codefWebClient;

    // redis에 각 회원의 월별 소비패턴 정보를 저장함
    private final MonthSpendingPatternRedisRepository monthSpendingPatternRedisRepository;
    private final DaySpendingPatternRedisRepository daySpendingPatternRedisRepository;

    /**
     * 회원들의 소비내역을 불러와 spending에 저장
     * @throws UnsupportedEncodingException
     */
    @Override
    public void addSpending(User user, String startDate, String endDate) {
        // codef api 호출
        // 리스트로 받아서 한꺼번에 저장
        List<Spending> spendingList;
        try {
            spendingList = codefWebClient.findSpendingList(FindSpendingListReqDto.create(user, startDate.toString(), endDate.toString()), user.getUserId());
            spendingRepository.saveAll(spendingList);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }



    /**
     * 월별 소비패턴 분석한 값을 반환
     * @return
     */
    @Override
    public FindMonthSpendingResDto findMonthSpending() {
        String email = getLoginId();
        Map<String, Long> spendingAmountMap;
        // 이미 분석해서 redis에 저장해놓은 상태면 반환함
        Optional<MonthSpendingPattern> monthSpendingPattern = monthSpendingPatternRedisRepository.findById(email);
        // date로 캘린더 생성
        Date now = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);

        // 년, 월 값 가져오기
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);

        if(!monthSpendingPattern.isPresent()) {
            // redis에 저장된 데이터가 없으면 분석해서 새로 redis에 저장함
            User user = userRepository.findByEmail(email).orElseThrow(() -> new UserNotFoundException(UserExceptionMessage.USER_NOT_FOUND.getMessage()));
            // 중복된 코드가 너무 많음 -> 코드 리팩토링 필요,,,
            // 해당 년 월의 마지막 날을 가져오기
            YearMonth yearMonth = YearMonth.of(year, month);
            int lastDay = yearMonth.lengthOfMonth();
            StringBuilder startDate = new StringBuilder();
            StringBuilder endDate = new StringBuilder();
            // 달이 10 미만이라면 앞에 0을 붙여줘야 함
            if(month < 10) {
                startDate.append(year).append(0).append(month).append("01");
                endDate.append(year).append(0).append(month).append(lastDay);
            }else {
                startDate.append(year).append(month).append("01");
                endDate.append(year).append(month).append(lastDay);
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
            try {
                updateMonthSpending(user, month, sdf.parse(startDate.toString()), sdf.parse(endDate.toString()));
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        }
        monthSpendingPattern = monthSpendingPatternRedisRepository.findById(email);
        // 응답 객체 반환
        return FindMonthSpendingResDto.builder()
                .month(month)
                .spendingAmountList(monthSpendingPattern.get().getSpendingAmountList())
                .totalAmount(monthSpendingPattern.get().getTotalAmount())
                .build();
    }

    /**
     * 일일 소비패턴 분석 데이터 redis에서 반환
     * @return
     */
    @Override
    public FindDaySpendingResDto findDaySpending() {
        String email = getLoginId();
        List<SpendingDto> spendingAmountList;
        Optional<DaySpendingPattern> daySpendingPattern = daySpendingPatternRedisRepository.findById(email);
        spendingAmountList = daySpendingPattern.get().getSpendingAmountList();

        return FindDaySpendingResDto.builder()
                .month(daySpendingPattern.get().getMonth())
                .day(daySpendingPattern.get().getDay())
                .spendingAmountList(spendingAmountList)
                .totalAmount(daySpendingPattern.get().getTotalAmount())
                .lessSpent(daySpendingPattern.get().getLessSpent())
                .maxSpentCategoryList(daySpendingPattern.get().getMaxSpentCategoryList())
                .maxAmount(daySpendingPattern.get().getMaxAmount())
                .build();
    }

    /**
     * 소비패턴 내역에서 업종 별로 사용 합계를 계산함
     * @param spendingList
     */
    @Override
    public MonthSpendingPattern analyzeMonthSpending(List<Spending> spendingList, String email, int month) {
        // 카테고리 별 합계 저장
        List<SpendingDto> spendingAmountList = new ArrayList<>();
        // 카테고리의 index 지정
        Map<String, Integer> map = new HashMap<>();
        String category; // 소비 유형
        Long totalAmount = 0L;
        Long amount;
        SpendingDto spendingDto;
        // 리스트에서의 index
        Integer idx;
        // 중복이 아닌 카테고리 개수
        int cnt = 0;
        for (Spending spending : spendingList) {
            category = spending.getCategory();
            idx = map.get(category);
            if(idx == null) {
                // 처음 등장한 유형인 경우
                idx = cnt;
                map.put(category, cnt++);
            }
            spendingDto = spendingAmountList.get(idx);
            amount = spending.getCost();
            totalAmount += spending.getCost();
            spendingDto.addAmount(amount);
        }

        return MonthSpendingPattern.builder()
                .email(email)
                .month(month)
                .spendingAmountList(spendingAmountList)
                .totalAmount(totalAmount)
                .expiration(getMonthExpritation())
                .build();
    }


    @Override
    public DaySpendingPattern analyzeDaySpending(List<Spending> todaySpendingList, String email, int month, int day) {
        // balance 업데이트 필요..
        // 어제
        // 카테고리 별 합계 저장
        List<SpendingDto> spendingAmountList = new ArrayList<>();
        List<String> maxSpentCategoryList = new ArrayList<>();
        // 카테고리의 index 지정
        Map<String, Integer> map = new HashMap<>();
        String category; // 소비 유형
        Long totalAmount = 0L;
        Long maxAmount = 0L;
        Long amount;
        SpendingDto spendingDto;
        // 리스트에서의 index
        Integer idx;
        // 중복이 아닌 카테고리 개수
        int cnt = 0;
        for (Spending spending : todaySpendingList) {
            category = spending.getCategory();
            idx = map.get(category);
            if(idx == null) {
                // 처음 등장한 유형인 경우
                idx = cnt;
                map.put(category, cnt++);
            }
            spendingDto = spendingAmountList.get(idx);
            amount = spending.getCost();
            totalAmount += spending.getCost();
            spendingDto.addAmount(amount);
        }

        // 최댓값 확인
        for (SpendingDto dto : spendingAmountList) {
            maxAmount = Math.max(maxAmount, dto.getAmount());
        }

        // 가장 많이 소비한 유형을 저장
        for (SpendingDto dto : spendingAmountList) {
            if(maxAmount == dto.getAmount())
                maxSpentCategoryList.add(dto.getCategory());
        }

        // 그저께
        // redis에 저장되어있는 값이 그저께 분석한 일일 소비배턴 분석 데이터
        Optional<DaySpendingPattern> yesterday = daySpendingPatternRedisRepository.findById(email);

        Boolean lessSpent = null;

        if(totalAmount > yesterday.get().getTotalAmount()) lessSpent = false;
        if(totalAmount < yesterday.get().getTotalAmount()) lessSpent = true;

        return DaySpendingPattern.builder()
                .email(email)
                .month(month)
                .day(day)
                .spendingAmountList(spendingAmountList)
                .totalAmount(totalAmount)
                .lessSpent(lessSpent)
                .maxSpentCategoryList(maxSpentCategoryList)
                .maxAmount(maxAmount)
                .expiration(TimeEnums.DAY_TIME_VALUE.getValue() + TimeEnums.HOUR_TIME_VALUE.getValue())
                .build();
    }

    /**
     * 해당 회원의 월 소비 패턴을 갱신 (매달 1일마다 갱신됨)
     * @param user
     * @param startDate
     * @param endDate
     */
    @Override
    public void updateMonthSpending(User user, int month, Date startDate, Date endDate) {
        List<Spending> spendingList = spendingRepository.findSpendingByUserIdAndSpentDateBetween(user.getUserId(), startDate, endDate);
        MonthSpendingPattern monthSpendingPattern = analyzeMonthSpending(spendingList, user.getEmail(), month);
        monthSpendingPatternRedisRepository.save(monthSpendingPattern);
    }

    @Override
    public void updateDaySpending(User user, int month, int day, Date startDate, Date endDate) {
        List<Spending> todaySpendingList = spendingRepository.findSpendingByUserIdAndSpentDateBetween(user.getUserId(), startDate, endDate);
        DaySpendingPattern daySpendingPattern = analyzeDaySpending(todaySpendingList, user.getEmail(), month, day);
        // 회원의 balance 업데이트
        // 100원당 1 코인
        user.updateBalance(daySpendingPattern.getTotalAmount() / 100);
        daySpendingPatternRedisRepository.save(daySpendingPattern);
    }

    /**
     * 현재 달의 마지막날 까지가 redis에 존재하는 유효기간
     * 그 값을 반환
     * @return
     */
    private Long getMonthExpritation(){
        // 어제 날짜 구하기 (시스템 시계, 시스템 타임존)
        LocalDate yesterday = LocalDate.now().minusDays(1);

        // 연도, 월, 일
        int year = yesterday.getYear();
        int month = yesterday.getMonthValue();

        // 해당 년 월의 마지막 날을 가져오기
        YearMonth yearMonth = YearMonth.of(year, month);
        int lastDay = yearMonth.lengthOfMonth();

        // 한 달의 일수 * 1일 시간단위
        return lastDay * TimeEnums.DAY_TIME_VALUE.getValue();
    }

    /**
     * 현재 로그인한 회원 아이디(이메일)을 반환
     */
    private String getLoginId() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserDetails principal = (UserDetails) authentication.getPrincipal();
        return principal.getUsername();
    }


}
