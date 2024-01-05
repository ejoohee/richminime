package com.richminime.domain.spending.constatnt;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum TimeEnums {

    DAY_TIME_VALUE(" 1일 시간 값 ", 1000L * 60 * 60 * 24),
    HOUR_TIME_VALUE(" 1시간 값 ", 1000L * 60 * 60),
    MINUTE_TIME_VALUE(" 1분 값 ", 1000L * 60);

    private String description;
    private Long value;

}
