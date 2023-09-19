package com.richminime.global.exception.security;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SecurityExceptionMessage {

    MISMATCH_TOKEN_ID("토큰 생성에 사용된 ID와 일치하지 않습니다."),
    INVALID_TOKEN("토큰 검증 실패");

    String message;

}
