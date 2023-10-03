package com.richminime.domain.item.exception;

import com.richminime.global.exception.ItemException;

public class ItemDuplicatedException extends ItemException {


    public ItemDuplicatedException(String msg) {
        super(msg);
    }
}
