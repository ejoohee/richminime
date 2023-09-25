package com.richminime.domain.clothing.constant;

public enum ClothingExceptionMessage {
    CLOTHING_NOT_FOUND("의상 조회 실패"),
    CLOTHING_DUPLICATED("의상 중복");

    private final String message;

    ClothingExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
