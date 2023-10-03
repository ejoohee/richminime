package com.richminime.domain.item.exception;

import com.richminime.global.exception.ItemException;

public class ItemNotFoundException extends ItemException {
    public ItemNotFoundException() {super("아이템 조회 불가");}

    public ItemNotFoundException(String message){super(message);}
}
