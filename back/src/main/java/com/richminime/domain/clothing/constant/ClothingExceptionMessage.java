package com.richminime.domain.clothing.constant;

public enum ClothingExceptionMessage {
    CLOTHING_NOT_FOUND("옷 조회에 실패했습니다."),
    CLOTHING_DUPLICATED("이미 옷이 존재합니다."),
    CLOTHING_COUNT_OVER("내 옷장이 가득 찼습니다."),
    CLOTHING_INSUFFICIENT_BALANCE("옷 살 돈이 부족합니다."),
    CLOTHING_USER_NOT_FOUND("옷 관련 유저 조회에 실패했습니다."),
    CLOTHING_AUTHORIZATION_FAILED("옷 관련 접근 권한 없습니다.");

    private final String message;

    ClothingExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
