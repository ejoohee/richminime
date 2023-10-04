package com.richminime.domain.character.exception;

import com.richminime.global.exception.NotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.FORBIDDEN, reason = "유저를 찾을 수 없음")
public class CharacterUserNotFoundException extends RuntimeException {
    private final Long errorCode;
    public CharacterUserNotFoundException(){
        this.errorCode = 200L;
    }
    public CharacterUserNotFoundException(String message) {
        super(message);
        this.errorCode = 200L;
    }

    public CharacterUserNotFoundException(String message, Long errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}

