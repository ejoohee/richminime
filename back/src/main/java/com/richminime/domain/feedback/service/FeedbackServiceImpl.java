package com.richminime.domain.feedback.service;

import com.richminime.domain.feedback.domain.Feedback;
import com.richminime.domain.feedback.domain.FeedbackType;
import com.richminime.domain.feedback.dto.FeedbackReqDto;
import com.richminime.domain.feedback.dto.FeedbackResDto;
import com.richminime.domain.feedback.repository.FeedbackRepository;
import com.richminime.domain.spending.repository.SpendingRepository;
import com.richminime.domain.spending.service.SpendingService;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.domain.UserType;
import com.richminime.domain.user.dto.response.FindUserResDto;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.domain.user.service.UserService;
import com.richminime.global.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import javax.transaction.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor
public class FeedbackServiceImpl implements FeedbackService {

    private final FeedbackRepository feedbackRepository;
    private final UserRepository userRepository;
    private final SpendingRepository spendingRepository;
    private final SpendingService spendingService;
    private final SecurityUtils securityUtils;
    private String email;

    @Override
    public FeedbackResDto findFeedback() {
        log.info("[피드백 추천] 로그인 유저 반환. email : {}", email);

        User loginUser = userRepository.findByEmail(email)
                .orElseThrow(() ->
                {
                    log.error("[피드백 추천] 로그인 유저를 찾을 수 없습니다.");
                    return new ResponseStatusException(HttpStatus.NOT_FOUND, "로그인 유저를 찾을 수 없습니다.");
                });

        // 스펜딩 불러오기


        return null;
    }

    private boolean isAdmin() {
        User loginUser = userRepository.findByEmail(email)
                .orElseThrow(() -> {
                    log.error("[피드백 서비스] 로그인 유저를 찾을 수 없습니다.");
                    return new ResponseStatusException(HttpStatus.NOT_FOUND, "로그인 유저를 찾을 수 없습니다.");
                });

        if(loginUser.getUserType().equals(UserType.ROLE_ADMIN))
            return true;

        return false;
    }

    @Transactional
    @Override
    public FeedbackResDto addFeedback(FeedbackReqDto feedbackReqDto) {
        log.info("[피드백 등록] 피드백 등록 요청.");

        // 관리자 확인
        if(!isAdmin()) {
            log.error("[피드백 등록] 관리자 회원만 피드백 등록이 가능합니다.");
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "등록 권한이 없습니다.");
        };

        Feedback feedback = Feedback.builder()
                .feedbackType(FeedbackType.getFeedbackType(feedbackReqDto.getFeedbackType()))
                .content(feedbackReqDto.getContent())
                .build();

        feedbackRepository.save(feedback);

        log.info("[피드백 등록] 피드백 등록 완료");

        return FeedbackResDto.entityToDto(feedback);
    }

    @Transactional
    @Override
    public FeedbackResDto updateFeedback(Long feedbackId, FeedbackReqDto feedbackReqDto) {
        log.info("[피드백 수정] 피드백 수정 요청. feedbackId : {}", feedbackId);

        // 관리자 확인
        if(!isAdmin()) {
            log.error("[피드백 수정] 관리자 회원만 피드백 수정이 가능합니다.");
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "수정 권한이 없습니다.");
        };

        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> {
                    log.error("[피드백 수정] 피드백을 찾을 수 없습니다");
                    return new ResponseStatusException(HttpStatus.NOT_FOUND, "피드백을 찾을 수 없습니다.");
                });

        feedback.updateFeedback(feedbackReqDto);
        feedbackRepository.save(feedback);

        log.info("[피드백 수정] 피드백 수정 완료");
        return FeedbackResDto.entityToDto(feedback);
    }

    @Transactional
    @Override
    public void deleteFeedback(Long feedbackId) {
        log.info("[피드백 삭제] 피드백 삭제 요청. feedbackId : {]", feedbackId);

        // 관리자 확인
        if(!isAdmin()) {
            log.error("[피드백 삭제] 관리자 회원만 피드백 삭제가 가능합니다.");
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "삭제 권한이 없습니다.");
        };

        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> {
                    log.error("[피드백 삭제] 피드백을 찾을 수 없습니다");
                    return new ResponseStatusException(HttpStatus.NOT_FOUND, "피드백을 찾을 수 없습니다.");
                });

        feedbackRepository.delete(feedback);
        log.info("[피드백 삭제] 피드백 삭제 완료.");
    }
}
