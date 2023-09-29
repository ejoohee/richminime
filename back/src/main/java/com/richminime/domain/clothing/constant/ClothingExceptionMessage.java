package com.richminime.domain.clothing.constant;

public enum ClothingExceptionMessage {
    CLOTHING_NOT_FOUND("의상 조회 실패"),
    CLOTHING_DUPLICATED("의상 중복"),
    CLOTHING_COUNT_OVER("의상 수량 초과");

    private final String message;

    ClothingExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
