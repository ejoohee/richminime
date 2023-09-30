package com.richminime.domain.feedback.constant;

import lombok.Getter;

@Getter
public enum FeedbackType {

    긍정피드백("긍정피드백"),
    부정피드백("부정피드백");
    private String value;

    FeedbackType(String value) {
        this.value = value;
    }

    public static FeedbackType getFeedbackType(String value) {
        if(value.contains("긍정"))
            return 긍정피드백;
        else
            return 부정피드백;
    }

}
