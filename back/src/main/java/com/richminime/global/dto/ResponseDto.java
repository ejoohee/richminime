package com.richminime.global.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class ResponseDto<T> {

    private String msg;
    private T data;

    public static <T> ResponseDto<T> create(String msg) {
        return new ResponseDto<>(msg, null);
    }

    public static <T> ResponseDto<T> create(String msg, T data) {
        return new ResponseDto<>(msg, data);
    }
}

