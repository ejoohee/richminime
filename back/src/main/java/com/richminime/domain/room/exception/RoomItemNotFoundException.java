package com.richminime.domain.room.exception;

import com.richminime.global.exception.ItemException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.FORBIDDEN, reason = "아이템을 찾을 수 없음")
public class RoomItemNotFoundException extends RuntimeException {
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
