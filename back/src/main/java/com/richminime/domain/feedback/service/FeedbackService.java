package com.richminime.domain.feedback.service;

import com.richminime.domain.feedback.dto.FeedbackReqDto;
import com.richminime.domain.feedback.dto.FeedbackResDto;

public interface FeedbackService {

    // 유저의 소비패턴에 따른 피드백 랜덤추출 1일 1회
    FeedbackResDto findFeedback();
    
    // 관리자 권한 확인
    // 피드백 등록
    FeedbackResDto addFeedback(FeedbackReqDto feedbackReqDto);

    // 피드백 수정
    FeedbackResDto updateFeedback(Long feedbackId, FeedbackReqDto feedbackReqDto);

    // 피드백 삭제
    void deleteFeedback(Long feedbackId);
}
