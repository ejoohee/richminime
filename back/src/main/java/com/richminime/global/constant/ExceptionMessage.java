package com.richminime.global.constant;

public enum ExceptionMessage {
    AUTHENTICATION_FAILED("인증 실패"),
    AUTHORIZATION_FAILED("접근 권한 없음"),
    INSUFFICINET_BALANCE("잔액 부족");

    private final String message;

    ExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return this.message;
    }
}
