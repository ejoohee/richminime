package com.richminime.domain.clothing.constant;

public enum ClothingExceptionMessage {
    CLOTHING_NOT_FOUND("의상 조회에 실패했습니다."),
    CLOTHING_DUPLICATED("의상이 이미 존재합니다."),
    CLOTHING_COUNT_OVER("내 옷장이 가득 찼습니다.");

    private final String message;

    ClothingExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
