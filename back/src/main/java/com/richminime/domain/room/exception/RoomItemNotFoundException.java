package com.richminime.domain.room.exception;

import com.richminime.global.exception.ItemException;

public class RoomItemNotFoundException extends ItemException {
    private final Long errorCode;
    public RoomItemNotFoundException(){
        this.errorCode = 200L;
    }
    public RoomItemNotFoundException(String message) {
        super(message);
        this.errorCode = 200L;
    }

    public RoomItemNotFoundException(String message, Long errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
