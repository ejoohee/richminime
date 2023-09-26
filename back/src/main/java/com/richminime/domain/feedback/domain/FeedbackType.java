package com.richminime.domain.feedback.domain;

import lombok.Getter;

@Getter
public enum FeedbackType {

    POSITIVE("긍정 피드백"),
    NEGATIVE("부정 피드백"),
    RANDOM("랜덤 피드백");

    private String value;

    FeedbackType(String value) {
        this.value = value;
    }

    public static FeedbackType getFeedbackType(String value) {
        if(value.contains("긍정"))
            return POSITIVE;

        else if(value.contains("부정"))
            return NEGATIVE;

        return RANDOM;
    }

}
