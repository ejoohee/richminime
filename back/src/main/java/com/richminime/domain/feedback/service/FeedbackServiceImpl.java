package com.richminime.domain.feedback.service;

import com.richminime.domain.feedback.domain.Feedback;
import com.richminime.domain.feedback.constant.FeedbackType;
import com.richminime.domain.feedback.dto.FeedbackReqDto;
import com.richminime.domain.feedback.dto.FeedbackResDto;
import com.richminime.domain.feedback.exception.FeedbackNotFoundException;
import com.richminime.domain.feedback.exception.FeedbackUserNotFoundException;
import com.richminime.domain.feedback.repository.FeedbackRepository;
import com.richminime.domain.spending.dto.response.FindDaySpendingResDto;
import com.richminime.domain.spending.service.SpendingService;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.domain.UserType;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.util.SecurityUtils;
import com.richminime.global.util.jwt.JWTUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

import static com.richminime.domain.feedback.constant.FeedbackExceptionMessage.*;
import static com.richminime.domain.user.exception.UserExceptionMessage.USER_NOT_FOUND;
import static com.richminime.global.constant.ExceptionMessage.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class FeedbackServiceImpl implements FeedbackService {

    private final FeedbackRepository feedbackRepository;
    private final UserRepository userRepository;
    private final SpendingService spendingService;
    private final SecurityUtils securityUtils;
    private final JWTUtil jwtUtil;

    /**
     * 전날 소비패턴에 따른 피드백 랜덤 추천
     * 로그인 사용자의 전날 소비패턴에 따라 피드백을 랜덤으로 추천합니다.
     * @return
     */
    @Override
    public FeedbackResDto findFeedback() {
        String email = securityUtils.getLoggedInUserEmail();

        log.info("[피드백 추천] 로그인 유저 반환. email : {}", email);

        User loginUser = userRepository.findByEmail(email)
                .orElseThrow(() -> {
                    log.error("[피드백 추천] 로그인 유저를 찾을 수 없습니다.");
                    return new FeedbackUserNotFoundException(USER_NOT_FOUND.getMessage());
                });

        log.info("[피드백 추천] findDaySpending 불러오기 요청");
        // 스펜딩 불러오기
        FindDaySpendingResDto daySpending = spendingService.findDaySpending();
        log.info("[피드백 추천] findDaySpending 불러오기 성공 !! 긍/부정 : {}", daySpending.getLessSpent());

        String feedbackType;
        if(daySpending.getLessSpent())
            feedbackType = "긍정피드백";
        else
            feedbackType = "부정피드백";

        Feedback feedback = feedbackRepository.findByFeedbackTypeToRandom(feedbackType);

        log.info("[피드백 추천] 피드백 랜덤 추천 완료. 피드백 타입 : {}", feedbackType);
        return FeedbackResDto.builder()
                .feedbackType(feedback.getFeedbackType().getValue())
                .content(feedback.getContent())
                .build();
    }

    /**
     * 로그인 유저가 관리자인지 체크합니다.
     * @return
     */
    private boolean isAdmin() {
        String email = securityUtils.getLoggedInUserEmail();

        User loginUser = userRepository.findByEmail(email)
                .orElseThrow(() -> {
                    log.error("[피드백 서비스] 로그인 유저를 찾을 수 없습니다.");
                    return new FeedbackUserNotFoundException(USER_NOT_FOUND.getMessage());
                });

        if(loginUser.getUserType().equals(UserType.ROLE_ADMIN))
            return true;

        return false;
    }

    /**
     * 피드백 등록
     * 관리자 회원만 피드백 등록이 가능합니다.
     * @param feedbackReqDto
     * @return
     */
    @Transactional
    @Override
    public FeedbackResDto addFeedback(FeedbackReqDto feedbackReqDto) {
        log.info("[피드백 등록] 피드백 등록 요청.");

        if(!isAdmin()) {
            log.error("[피드백 등록] 관리자 회원만 피드백 등록이 가능합니다.");
            throw new FeedbackUserNotFoundException(AUTHORIZATION_FAILED.getMessage());
        };

        Feedback feedback = Feedback.builder()
                .feedbackType(FeedbackType.getFeedbackType(feedbackReqDto.getFeedbackType()))
                .content(feedbackReqDto.getContent())
                .build();

        feedbackRepository.save(feedback);

        log.info("[피드백 등록] 피드백 등록 완료 feedbackId : {}", feedback.getFeedbackId());
        return FeedbackResDto.entityToDto(feedback);
    }

    /**
     * 피드백 수정
     * 관리자 회원만 피드백 수정이 가능합니다.
     * @return
     */
    @Transactional
    @Override
    public FeedbackResDto updateFeedback(Long feedbackId, FeedbackReqDto feedbackReqDto) {
        log.info("[피드백 수정] 피드백 수정 요청. feedbackId : {}", feedbackId);

        if(!isAdmin()) {
            log.error("[피드백 수정] 관리자 회원만 피드백 수정이 가능합니다.");
            throw new FeedbackUserNotFoundException(AUTHORIZATION_FAILED.getMessage());
        };

        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> {
                    log.error("[피드백 수정] 피드백을 찾을 수 없습니다");
                    return new FeedbackNotFoundException(FEEDBACK_NOT_FOUND.getMessage());
                });

        feedback.updateFeedback(feedbackReqDto);
        feedbackRepository.save(feedback);

        log.info("[피드백 수정] 피드백 수정 완료");
        return FeedbackResDto.entityToDto(feedback);
    }

    /**
     * 피드백 삭제
     * 관리자 회원만 피드백 삭제가 가능합니다.
     * @return
     */
    @Transactional
    @Override
    public void deleteFeedback(Long feedbackId) {
        log.info("[피드백 삭제] 피드백 삭제 요청. feedbackId : {]", feedbackId);

        if(!isAdmin()) {
            log.error("[피드백 삭제] 관리자 회원만 피드백 삭제가 가능합니다.");
            throw new FeedbackUserNotFoundException(AUTHORIZATION_FAILED.getMessage());
        };

        Feedback feedback = feedbackRepository.findById(feedbackId)
                .orElseThrow(() -> {
                    log.error("[피드백 삭제] 피드백을 찾을 수 없습니다");
                    return new FeedbackNotFoundException(FEEDBACK_NOT_FOUND.getMessage());
                });

        feedbackRepository.delete(feedback);
        log.info("[피드백 삭제] 피드백 삭제 완료.");
    }

}
