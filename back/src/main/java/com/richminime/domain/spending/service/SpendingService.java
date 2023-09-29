package com.richminime.domain.spending.service;

import com.richminime.domain.spending.domain.DaySpendingPattern;
import com.richminime.domain.spending.domain.MonthSpendingPattern;
import com.richminime.domain.spending.domain.Spending;
import com.richminime.domain.spending.dto.response.FindDaySpendingResDto;
import com.richminime.domain.spending.dto.response.FindMonthSpendingResDto;
import com.richminime.domain.user.domain.User;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface SpendingService {

    // 매일 자정마다 그 전날 소비내역 불러옴
    void addSpending(User user, String startDate, String endDate);

    FindMonthSpendingResDto findMonthSpending();

    FindDaySpendingResDto findDaySpending();

    // 월별 분석 -> 지금 날짜를 기준으로 그 전달 1달치
    MonthSpendingPattern analyzeMonthSpending(List<Spending> spendingList, String email, int month);

    // 일별 분석 -> 전날을 전전날과 비교
    // 피드백 쪽에 비교까지 다 끝낸 상태로 넘겨줌
    DaySpendingPattern analyzeDaySpending(List<Spending> spendingList, String email, int month, int day);

    void updateMonthSpending(User user, int month, Date startDate, Date endDate);

    void updateDaySpending(User user, int month, int day, Date startDate, Date endDate);

    // 회원가입 초기에 사용함
    // 그저께 가져와서 redis에 저장함(회원가입 당시엔 redis에 저장된게 없어서)
    void initDaySpending(User user, int month, int day, Date startDate, Date endDate);


}
