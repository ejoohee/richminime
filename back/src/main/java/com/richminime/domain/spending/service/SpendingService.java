package com.richminime.domain.spending.service;

import com.richminime.domain.user.domain.User;

import java.io.UnsupportedEncodingException;
import java.util.Date;

public interface SpendingService {

    // 회원가입 날짜 기준 그 전달 소비 내역 spending 테이블에 저장?
    void addMonthSpending(Date now, User user) throws UnsupportedEncodingException;

    // 매일 자정마다 그 전날 소비내역 불러옴
    void addDaySpending() throws UnsupportedEncodingException;

    // 월별 분석 -> 지금 날짜를 기준으로 그 전달 1달치


    // 일별 분석 -> 오늘치를 어제꺼랑 비교?


}
