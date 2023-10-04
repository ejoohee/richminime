package com.richminime.domain.clothing.exception;

import com.richminime.global.exception.ClothingException;

public class ClothingNotFoundException extends ClothingException {
    public ClothingNotFoundException() {super("옷 조회에 실패했습니다.");}

    public ClothingNotFoundException(String message) {
        super(message);
    }
}
