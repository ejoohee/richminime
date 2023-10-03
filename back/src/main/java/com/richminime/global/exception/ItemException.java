package com.richminime.global.exception;

public class ItemException extends IllegalArgumentException {

    public ItemException() {
        super("아이템 관련 어떠한 에러");
    }
    public ItemException(String message) {
        super(message);
    }
}
