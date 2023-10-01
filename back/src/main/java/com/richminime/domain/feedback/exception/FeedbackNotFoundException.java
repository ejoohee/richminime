package com.richminime.domain.feedback.exception;

import com.richminime.global.exception.NotFoundException;

public class FeedbackNotFoundException extends NotFoundException {

    public FeedbackNotFoundException() {
        super();
    }

    public FeedbackNotFoundException(String message) {
        super(message);
    }
}
