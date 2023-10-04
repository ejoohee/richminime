package com.richminime.domain.room.exception;

import com.richminime.global.exception.NotFoundException;

public class RoomUserNotFoundException extends NotFoundException {
    private final Long errorCode;
    public RoomUserNotFoundException(){
        this.errorCode = 200L;
    }
    public RoomUserNotFoundException(String message) {
        super(message);
        this.errorCode = 200L;
    }

    public RoomUserNotFoundException(String message, Long errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}

