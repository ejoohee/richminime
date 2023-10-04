package com.richminime.domain.room.exception;

import com.richminime.global.exception.NotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.FORBIDDEN, reason = "유저를 찾을 수 없음")
public class RoomUserNotFoundException extends RuntimeException {
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

