package com.richminime.domain.user.exception;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserExceptionMessage {

    USER_NOT_FOUND("존재하지 않는 회원입니다."),
    CONNECTED_ID_NOT_CREATED("아직 커넥티드 아이디가 생성되지 않았습니다."),
    LOGIN_PASSWORD_ERROR("비밀번호가 일치하지 않습니다.");

    private String message;

}
