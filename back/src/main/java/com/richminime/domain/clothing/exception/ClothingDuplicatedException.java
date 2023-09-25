package com.richminime.domain.clothing.exception;

import com.richminime.global.exception.DuplicatedException;

public class ClothingDuplicatedException extends DuplicatedException {
    public ClothingDuplicatedException() {
        super();
    }

    public ClothingDuplicatedException(String message) {
        super(message);
    }
}
