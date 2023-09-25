package com.richminime.domain.spending.service;

import com.richminime.domain.spending.domain.MonthSpendingPattern;
import com.richminime.domain.spending.domain.Spending;
import com.richminime.domain.spending.dto.response.FindMonthSpendingResDto;
import com.richminime.domain.user.domain.User;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface SpendingService {

    // 회원가입 날짜 기준 그 전달 소비 내역 spending 테이블에 저장?
//    void addMonthSpending(User user, String startDate, String endDate);

    // 매일 자정마다 그 전날 소비내역 불러옴
    void addSpending(User user, String startDate, String endDate);

    FindMonthSpendingResDto findMonthSpending();

    MonthSpendingPattern analyzeMonthSpending(List<Spending> spendingList, String email, int month);

    void analyzeDaySpending();

    void updateMonthSpending(User user, int month, Date startDate, Date endDate);

    // 월별 분석 -> 지금 날짜를 기준으로 그 전달 1달치


    // 일별 분석 -> 오늘치를 어제꺼랑 비교?


}
