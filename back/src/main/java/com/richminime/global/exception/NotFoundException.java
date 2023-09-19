package com.richminime.global.exception;

public class NotFoundException extends IllegalArgumentException{

    public NotFoundException() {
        super("찾을 수 없음");
    }

    public NotFoundException(String message) {
        super(message);
    }

}
