package com.richminime.domain.clothing.exception;

import com.richminime.global.exception.ClothingException;

public class ClothingInsufficientBalanceException extends ClothingException {

    public ClothingInsufficientBalanceException() {
        super("옷 살 돈이 부족합니다.");
    }

    public ClothingInsufficientBalanceException(String msg) {
        super(msg);
    }
}
