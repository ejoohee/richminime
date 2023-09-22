package com.richminime.domain.feedback.service;

import com.richminime.domain.feedback.dto.FeedbackReqDto;
import com.richminime.domain.feedback.dto.FeedbackResDto;
import com.richminime.domain.feedback.repository.FeedbackRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class FeedbackServiceImpl implements FeedbackService {

    private final FeedbackRepository feedbackRepository;

    @Override
    public FeedbackResDto findFeedback(String token) {
        return null;
    }

    @Override
    public FeedbackResDto addFeedback(FeedbackReqDto feedbackReqDto, String token) {
        return null;
    }

    @Override
    public FeedbackResDto updateFeedback(Long feedbackId, FeedbackReqDto feedbackReqDto, String token) {
        return null;
    }

    @Override
    public void deleteFeedback(Long feedbackId, String token) {

    }
}
