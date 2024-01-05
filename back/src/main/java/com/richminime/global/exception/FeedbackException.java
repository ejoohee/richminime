package com.richminime.global.exception;

public class FeedbackException extends IllegalArgumentException {

    public FeedbackException() {
        super("피드백 관련 어떠한 에러");
    }

    public FeedbackException(String msg) {
        super(msg);
    }
}
