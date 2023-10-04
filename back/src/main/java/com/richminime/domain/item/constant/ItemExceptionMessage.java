package com.richminime.domain.item.constant;

public enum ItemExceptionMessage {

    ITEM_NOT_FOUND("아이템 조회 실패"),
    ITEM_DUPLICATED("아이템 중복"),
    ITEM_COUNT_OVER("아이템 수량 초과");

    private final String message;

    ItemExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return this.message;
    }

}
