package com.richminime.domain.room.exception;

import com.richminime.global.exception.NotFoundException;

public class RoomNotFoundException extends NotFoundException {
    public RoomNotFoundException() {super();}

    public RoomNotFoundException(String message){super(message);}
}
