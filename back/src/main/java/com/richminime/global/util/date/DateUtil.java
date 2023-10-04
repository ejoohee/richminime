package com.richminime.global.util.date;

import com.richminime.domain.spending.constatnt.TimeEnums;
import com.richminime.global.common.codef.dto.request.DateDto;

import java.time.LocalDate;
import java.time.YearMonth;

/**
 * 날짜 관련 함
 */
public class DateUtil {


    /**
     * 지금 시간에서 며칠 후 날짜를 구해서 반환하는 함수
     * @param plusDay
     * @return
     */
    public static LocalDate getPlusTimeFromNow(int plusDay) {
        return LocalDate.now().plusDays(plusDay);
    }

    /**
     * 지금 시간에서 며칠 전 날짜를 구해서 반환하는 함수
     * @param minusDay
     * @return
     */
    public static LocalDate getMinusTimeFromNow(int minusDay) {
        return LocalDate.now().minusDays(minusDay);
    }

    /**
     * 해당 시간에서 년 월 일 가져옴
     * @param time
     * @return
     */
    public static DateDto getYearMonthDay(LocalDate time) {
        return DateDto.builder()
                .year(time.getYear())
                .month(time.getMonthValue())
                .day(time.getDayOfMonth())
                .build();
    }

    /**
     * 해당 년 월 일을 바탕으로 yyyyMMdd 형태의 문자열로 변환하여 반환하는 함수
     * @return
     */
    public static String parseDateToString(DateDto dateDto){
        int year = dateDto.getYear();
        int month = dateDto.getMonth();
        int day = dateDto.getDay();
        StringBuilder sb = new StringBuilder();
        sb.append(year);
        // 달이 10 미만이라면 앞에 0을 붙여줘야 함
        if(month < 10) {
            sb.append(0).append(month);
        }else {
            sb.append(month);
        }
        // 일이 10 미만이라면 앞에 0을 붙여줘야 함
        if(day < 10) {
            sb.append(0).append(day);
        }else {
            sb.append(day);
        }

        return sb.toString();
    }

    /**
     * 현재 달의 마지막날 까지가 redis에 존재하는 유효기간
     * 그 값을 반환
     * @return
     */
    public static Long getMonthExpiration(LocalDate time){
        // 연도, 월, 일
        int year = time.getYear();
        int month = time.getMonthValue();

        // 해당 년 월의 마지막 날을 가져오기
        YearMonth yearMonth = YearMonth.of(year, month);
        int lastDay = yearMonth.lengthOfMonth();

        // 한 달의 일수 * 1일 시간단위
        return lastDay * TimeEnums.DAY_TIME_VALUE.getValue();
    }


}
