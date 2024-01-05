package com.richminime.domain.character.exception;

import com.richminime.global.exception.ItemException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.FORBIDDEN, reason = "옷을 찾을 수 없음")
public class CharacterClothingNotFoundException extends RuntimeException {
    private final Long errorCode;
    public CharacterClothingNotFoundException(){
        this.errorCode = 200L;
    }
    public CharacterClothingNotFoundException(String message) {
        super(message);
        this.errorCode = 200L;
    }

    public CharacterClothingNotFoundException(String message, Long errorCode) {
        super(message);
        this.errorCode = errorCode;
    }
}
