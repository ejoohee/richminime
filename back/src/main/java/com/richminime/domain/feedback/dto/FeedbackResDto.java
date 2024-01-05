package com.richminime.domain.feedback.dto;

import com.richminime.domain.feedback.domain.Feedback;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class FeedbackResDto {

    private String feedbackType;
    private String content;

    // entity를 dto로 만드는 메서드
    public static FeedbackResDto entityToDto(Feedback feedback) {
        return FeedbackResDto.builder()
                .feedbackType(feedback.getFeedbackType().getValue())
                .content(feedback.getContent())
                .build();
    }

}
