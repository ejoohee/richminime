package com.richminime.domain.feedback.exception;

import com.richminime.global.exception.FeedbackException;

public class FeedbackNotFoundException extends FeedbackException {

    public FeedbackNotFoundException() {
        super();
    }

    public FeedbackNotFoundException(String message) {
        super(message);
    }
}
