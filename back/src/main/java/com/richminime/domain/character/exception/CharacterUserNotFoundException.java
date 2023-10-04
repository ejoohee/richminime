package com.richminime.domain.character.exception;

import com.richminime.global.exception.NotFoundException;

public class CharacterUserNotFoundException extends NotFoundException {
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

