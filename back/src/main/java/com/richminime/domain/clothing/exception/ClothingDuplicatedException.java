package com.richminime.domain.clothing.exception;

import com.richminime.global.exception.ClothingException;

public class ClothingDuplicatedException extends ClothingException {
    public ClothingDuplicatedException() {
        super("이미 옷이 존재합니다.");
    }

    public ClothingDuplicatedException(String message) {
        super(message);
    }
}
