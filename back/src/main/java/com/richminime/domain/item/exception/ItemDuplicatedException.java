package com.richminime.domain.item.exception;

import com.richminime.global.exception.DuplicatedException;

public class ItemDuplicatedException extends DuplicatedException {

    public ItemDuplicatedException() {
        super();
    }

    public ItemDuplicatedException(String msg) {
        super(msg);
    }
}
