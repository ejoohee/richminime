package com.richminime.domain.feedback.api;

import com.richminime.domain.feedback.dto.FeedbackReqDto;
import com.richminime.domain.feedback.dto.FeedbackResDto;
import com.richminime.domain.feedback.service.FeedbackService;
import com.richminime.global.dto.MessageDto;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/feedback")
public class FeedbackController {

    private final FeedbackService feedbackService;

    @Operation(
            summary = "피드백 등록",
            description = "관리자 회원만 피드백을 새로 등록할 수 있습니다."
    )
    @PostMapping
    public ResponseEntity<FeedbackResDto> addFeedback(@RequestBody FeedbackReqDto feedbackReqDto) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(feedbackService.addFeedback(feedbackReqDto));
    }

    @Operation(
            summary = "피드백 수정",
            description = "관리자 회원만 피드백을 수정할 수 있습니다."
    )
    @PutMapping("/{feedbackId}")
    public ResponseEntity<FeedbackResDto> updateFeedback(@PathVariable Long feedbackId, @RequestBody FeedbackReqDto feedbackReqDto) {
        return ResponseEntity.ok(feedbackService.updateFeedback(feedbackId, feedbackReqDto));
    }

    @Operation(
            summary = "피드백 삭제",
            description = "관리자 회원만 피드백을 삭제할 수 있습니다."
    )
    @DeleteMapping("/{feedbackId}")
    public ResponseEntity<MessageDto> deleteFeedback(@PathVariable Long feedbackId) {
        feedbackService.deleteFeedback(feedbackId);
        return ResponseEntity.ok(MessageDto.msg("DELETE SUCCESS"));
    }

    @Operation(
            summary = "피드백 추천",
            description = "로그인 유저별 소비패턴에 따른 1일 1회 피드백 랜덤 추천"
    )
    @GetMapping
    public ResponseEntity<FeedbackResDto> findFeedback() {
        return ResponseEntity.ok(feedbackService.findFeedback());
    }


}
