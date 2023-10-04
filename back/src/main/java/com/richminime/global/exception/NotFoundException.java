package com.richminime.global.exception;

public class NotFoundException extends IllegalArgumentException{

    public NotFoundException() {
        super("정보를 찾을 수 없습니다.");
    }

    public NotFoundException(String message) {
        super(message);
    }

}
