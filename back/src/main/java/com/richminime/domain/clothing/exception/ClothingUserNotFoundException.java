package com.richminime.domain.clothing.exception;

import com.richminime.global.exception.ClothingException;

public class ClothingUserNotFoundException extends ClothingException {

    public ClothingUserNotFoundException() {
        super("옷 관련 유저 조회 불가합니다.");
    }

    public ClothingUserNotFoundException(String message) {
        super(message);
    }
}

