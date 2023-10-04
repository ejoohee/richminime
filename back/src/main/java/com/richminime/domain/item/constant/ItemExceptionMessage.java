package com.richminime.domain.item.constant;

public enum ItemExceptionMessage {

    ITEM_NOT_FOUND("아이템 조회 실패"),
    USERITEM_NOT_FOUND("미소유 아이템 조회 실패"),
    ITEM_DUPLICATED("아이템 중복"),
    ITEM_COUNT_OVER("아이템 수량 초과"),
    ITEM_INSUFFICIENT_BALANCE("아이템 관련 잔액 부족"),
    ITEM_USER_NOT_FOUND("아이템 관련 유저 없음"),
    ITEM_AUTHORIZATION_FAILED("아이템 관련 접근 권한 없음"),
    USERITEM_AUTHORIZATION_FAILED("유저아이템 소유주와 불일치");

    private final String message;

    ItemExceptionMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return this.message;
    }

}
