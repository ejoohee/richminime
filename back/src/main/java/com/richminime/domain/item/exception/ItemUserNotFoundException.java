package com.richminime.domain.item.exception;

import com.richminime.global.exception.ItemException;

public class ItemUserNotFoundException extends ItemException {

    public ItemUserNotFoundException() {
        super("아이템 관련 유저 없음");
    }

    public ItemUserNotFoundException(String message) {
        super(message);
    }
}
