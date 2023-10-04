package com.richminime.domain.feedback.constant;

public enum FeedbackExceptionMessage {

    FEEDBACK_NOT_FOUND("피드백 조회 실패");

    private final String message;

    FeedbackExceptionMessage(String message){
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
