package com.richminime.domain.item.exception;

import com.richminime.global.exception.NotFoundException;

public class ItemNotFoundException extends NotFoundException {
    public ItemNotFoundException() {super();}

    public ItemNotFoundException(String message){super(message);}
}
