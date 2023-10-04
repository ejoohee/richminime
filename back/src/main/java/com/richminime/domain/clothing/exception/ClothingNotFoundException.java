package com.richminime.domain.clothing.exception;

import com.richminime.global.exception.ClothingException;

public class ClothingNotFoundException extends ClothingException {
    public ClothingNotFoundException() {
        super("옷 조회 불가합니다.");
    }

    public ClothingNotFoundException(String message) {
        super(message);
    }
}
