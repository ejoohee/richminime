package com.richminime.domain.feedback.service;

import com.richminime.domain.feedback.dto.FeedbackReqDto;
import com.richminime.domain.feedback.dto.FeedbackResDto;
import com.richminime.domain.feedback.repository.FeedbackRepository;
import com.richminime.domain.spending.repository.SpendingRepository;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.dto.response.FindUserResDto;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.domain.user.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

@Slf4j
@Service
@RequiredArgsConstructor
public class FeedbackServiceImpl implements FeedbackService {

    private final FeedbackRepository feedbackRepository;
    private final UserRepository userRepository;
    private final UserService userService; 
    private final SpendingRepository spendingRepository;

    private String getLoginUserEmail() {
        FindUserResDto loginUser = userService.findUser();
        
        return loginUser.getEmail();
    }
    
    @Override
    public FeedbackResDto findFeedback() {
        User loginUser = userRepository.findByEmail(getLoginUserEmail())
                .orElseThrow(() -> {
                    log.error("[피드백 반환] 로그인 유저를 찾을 수 없습니다.");
                    return new ResponseStatusException(HttpStatus.NOT_FOUND, "로그인 유저를 찾을 수 없습니다.");
                });

        // 스펜딩 불러오기

        return null;
    }

    @Override
    public FeedbackResDto addFeedback(FeedbackReqDto feedbackReqDto) {

        // 관리자 확인


        return null;
    }

    @Override
    public FeedbackResDto updateFeedback(Long feedbackId, FeedbackReqDto feedbackReqDto) {
        return null;
    }

    @Override
    public void deleteFeedback(Long feedbackId) {

    }
}
