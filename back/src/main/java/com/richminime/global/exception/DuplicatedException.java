package com.richminime.global.exception;

public class DuplicatedException extends IllegalArgumentException {

    public DuplicatedException() {
        super("이미 존재하는 정보입니다.");
    }

    public DuplicatedException(String message) {
        super(message);
    }
}
