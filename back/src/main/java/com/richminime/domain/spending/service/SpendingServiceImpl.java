package com.richminime.domain.spending.service;

import com.richminime.domain.spending.repository.SpendingRepository;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.common.codef.CodefWebClient;
import com.richminime.global.common.codef.dto.request.FindSpendingListReqDto;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.time.YearMonth;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class SpendingServiceImpl implements SpendingService {

    private final SpendingRepository spendingRepository;
    private final UserRepository userRepository;
    private final CodefWebClient codefWebClient;
    private final PasswordEncoder passwordEncoder;


    @Override
    public void addMonthSpending(Date now, User user) {
        // codef로 전 달 소비내역 모두 불러오기
        // date로 캘린더 생성
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(now);

        // 년, 월 값 가져오기
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);

        // 해당 년 월의 마지막 날을 가져오기
        YearMonth yearMonth = YearMonth.of(year, month);
        int lastDay = yearMonth.lengthOfMonth();
        StringBuilder startDate = new StringBuilder();
        StringBuilder endDate = new StringBuilder();
        // 달이 10 미만이라면 앞에 0을 붙여줘야 함
        if(month < 10) {
            startDate.append(year).append(0).append(month).append(01);
            endDate.append(year).append(0).append(month).append(lastDay);
        }else {
            startDate.append(year).append(month).append(01);
            endDate.append(year).append(month).append(lastDay);
        }
        // 리스트로 받아서 한꺼번에 저장
        try {
            spendingRepository.saveAll(codefWebClient.findSpendingList(FindSpendingListReqDto.create(user, startDate.toString(), endDate.toString()), user.getUserId()));
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 자정마다 호출
     * 회원들의 자정 기준 전날 소비내역을 불러와 spending에 저장
     * @throws UnsupportedEncodingException
     */
    @Override
    @Scheduled(cron = "0 0 0 * * *")
    public void addDaySpending() {
        // 오늘 날짜 확인
        // date로 캘린더 생성
        Date date = new Date();
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DATE, -1);

        // 년, 월 값 가져오기
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        StringBuilder startDate = new StringBuilder();
        StringBuilder endDate = new StringBuilder();
        startDate.append(year);
        endDate.append(year);
        // 달이 10 미만이라면 앞에 0을 붙여줘야 함
        if(month < 10) {
            startDate.append(0).append(month);
            endDate.append(0).append(month);
        }else {
            startDate.append(month);
            endDate.append(month);
        }
        // 일이 10 미만이라면 앞에 0을 붙여줘야 함
        if(day < 10) {
            startDate.append(0).append(day);
            endDate.append(0).append(day);
        }else {
            startDate.append(day);
            endDate.append(day);
        }
        // 가입 상태인 회원 목록에 따라 확인
        List<User> userList = userRepository.findAll();

        for (User user : userList) {
            // codef api 호출
            // 리스트로 받아서 한꺼번에 저장
            try {
                spendingRepository.saveAll(codefWebClient.findSpendingList(FindSpendingListReqDto.create(user, startDate.toString(), endDate.toString()), user.getUserId()));
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

    }

}
