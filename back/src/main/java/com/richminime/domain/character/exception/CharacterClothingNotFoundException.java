package com.richminime.domain.character.exception;

import com.richminime.global.exception.ItemException;

public class CharacterClothingNotFoundException extends ItemException {
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
