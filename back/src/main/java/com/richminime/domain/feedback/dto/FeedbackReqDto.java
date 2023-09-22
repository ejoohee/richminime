package com.richminime.domain.feedback.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class FeedbackReqDto {

    String feedbackType;
    String content;

}
