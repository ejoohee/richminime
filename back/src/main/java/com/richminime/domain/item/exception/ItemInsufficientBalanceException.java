package com.richminime.domain.item.exception;

import com.richminime.global.exception.ItemException;

public class ItemInsufficientBalanceException extends ItemException {

    public ItemInsufficientBalanceException() {
        super("아이템 관련 잔액부족");
    }

    public ItemInsufficientBalanceException(String msg) {
        super(msg);
    }
}
