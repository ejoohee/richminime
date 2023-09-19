package com.richminime.domain.clothing.exception;

import com.richminime.global.exception.NotFoundException;

public class ClothingNotFoundException extends NotFoundException {
    public ClothingNotFoundException() {
        super();
    }

    public ClothingNotFoundException(String message) {
        super(message);
    }
}
