package com.richminime.domain.user.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserExceptionMessage {

    USER_NOT_FOUND("회원 조회 실패");

    private String message;

}
