package com.richminime.domain.character.exception;

import com.richminime.global.exception.NotFoundException;

public class CharacterNotFoundException extends NotFoundException {
    public CharacterNotFoundException() {super();}

    public CharacterNotFoundException(String message){super(message);}
}
