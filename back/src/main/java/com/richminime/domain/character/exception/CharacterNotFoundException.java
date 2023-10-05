package com.richminime.domain.character.exception;

import com.richminime.global.exception.NotFoundException;

public class CharacterNotFoundException extends NotFoundException {
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
}
