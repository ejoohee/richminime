package com.richminime.global.exception;

public class ForbiddenException extends SecurityException {
    public ForbiddenException() {
        super("접근 차단");
    }

    public ForbiddenException(String message) {
        super(message);
    }
}
