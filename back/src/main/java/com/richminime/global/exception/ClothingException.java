package com.richminime.global.exception;

public class ClothingException extends IllegalArgumentException {

    public ClothingException() {
        super("옷 관련 어떠한 에러");
    }
    public ClothingException(String message) {
        super(message);
    }
}
