package com.richminime.domain.character.exception;

import com.richminime.global.exception.NotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.FORBIDDEN, reason = "캐릭터를 찾을 수 없음")
public class CharacterNotFoundException extends RuntimeException {
    private final Long errorCode;
    public CharacterNotFoundException(){
        this.errorCode = 200L;
    }
    public CharacterNotFoundException(String message) {
        super(message);
        this.errorCode = 200L;
    }

    public CharacterNotFoundException(String message, Long errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
/*    public CharacterNotFoundException(){

    }*/
}
