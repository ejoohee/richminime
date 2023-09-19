package com.richminime.global.exception;

public class DuplicatedException extends IllegalArgumentException {

    public DuplicatedException() {
        super("데이터 중복");
    }

    public DuplicatedException(String message) {
        super(message);
    }
}

