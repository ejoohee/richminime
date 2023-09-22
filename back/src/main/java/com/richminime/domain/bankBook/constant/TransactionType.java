package com.richminime.domain.bankBook.constant;

import com.richminime.global.exception.NotFoundException;

public enum TransactionType {
    적립("적립"),
    구매("구매"),
    판매("판매");

    private final String value;

    TransactionType(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    public static TransactionType getValue(String value) {
        for (TransactionType type : values()) {
            if (type.value.equalsIgnoreCase(value)) {
                return type;
            }
        }
        throw new NotFoundException();
    }
}
