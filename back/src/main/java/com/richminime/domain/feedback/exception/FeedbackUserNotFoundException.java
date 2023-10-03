package com.richminime.domain.feedback.exception;

import com.richminime.global.exception.FeedbackException;

public class FeedbackUserNotFoundException extends FeedbackException {

    public FeedbackUserNotFoundException() {
        super();
    }

    public FeedbackUserNotFoundException(String msg) {
        super(msg);
    }
}
