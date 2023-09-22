package com.richminime.domain.feedback.api;

import com.richminime.domain.feedback.dto.FeedbackReqDto;
import com.richminime.domain.feedback.dto.FeedbackResDto;
import com.richminime.domain.feedback.service.FeedbackService;
import com.richminime.global.dto.MessageDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/feedback")
public class FeedbackController {

    private final String ACCESS_TOKEN = "AccessToken";
    private final FeedbackService feedbackService;

    // 피드백 등록
    @PostMapping
    public ResponseEntity<FeedbackResDto> addFeedback(@RequestBody FeedbackReqDto feedbackReqDto, @RequestHeader(ACCESS_TOKEN) String token) {
        return null;
    }

    //  피드백 수정
    @PutMapping("/{feedbackId}")
    public ResponseEntity<FeedbackResDto> updateFeedback(@PathVariable Long feedbackId, @RequestBody FeedbackReqDto feedbackReqDto, @RequestHeader(ACCESS_TOKEN) String token) {
        return null;
    }


    // 피드백 삭제
    @DeleteMapping("/{feedbackId}")
    public ResponseEntity<MessageDto> deleteFeedback(@PathVariable Long feedbackId, @RequestHeader(ACCESS_TOKEN) String token) {
        feedbackService.deleteFeedback(feedbackId, token);
        return ResponseEntity.ok(MessageDto.msg("DELETE SUCCUESS"));
    }

    // 유저별 소비패턴에 따른 1일1회 랜덤 추출
    @GetMapping
    public ResponseEntity<FeedbackResDto> findFeedback(@RequestHeader(ACCESS_TOKEN) String token) {
        return null;
    }


}
