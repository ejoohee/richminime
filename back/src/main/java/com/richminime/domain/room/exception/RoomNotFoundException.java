package com.richminime.domain.room.exception;

import com.richminime.global.exception.NotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.FORBIDDEN, reason = "룸을 찾을 수 없음")
public class RoomNotFoundException extends RuntimeException {
    private final Long errorCode;
    public RoomNotFoundException(){
        this.errorCode = 200L;
    }
    public RoomNotFoundException(String message) {
        super(message);
        this.errorCode = 200L;
    }

    public RoomNotFoundException(String message, Long errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
