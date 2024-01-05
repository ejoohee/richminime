package com.richminime.domain.user.exception;

import com.richminime.domain.bankBook.constant.BankBookResponseMessage;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserExceptionMessage {

    SIGN_UP_NOT_VALID("회원가입에 필요한 정보가 입력되지 않았습니다."),
    EMAIL_CHECK_FAILED("이메일 인증을 해야 회원가입을 할 수 있습니다."),
    CARD_CHECK_FAILED("보유중인 카드가 아닙니다."),
    USER_NOT_FOUND("존재하지 않는 회원입니다."),
    CONNECTED_ID_NOT_CREATED("아직 커넥티드 아이디가 생성되지 않았습니다."),
    LOGIN_PASSWORD_ERROR("비밀번호가 일치하지 않습니다.");

    private String message;

}
