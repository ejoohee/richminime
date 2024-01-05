package com.richminime.global.exception;

public class ForbiddenException extends SecurityException {
    public ForbiddenException() {
        super("접근할 수 없습니다.");
    }

    public ForbiddenException(String message) {
        super(message);
    }
}
