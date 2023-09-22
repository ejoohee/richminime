package com.richminime.domain.bankBook.constant;

public enum BankBookResponseMessage {
    FIND_ALL_BANKBOOK("통장 목록 조회 완료");

    private final String message;

    BankBookResponseMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
