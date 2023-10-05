package com.richminime.domain.feedback.repository;

import com.richminime.domain.feedback.domain.Feedback;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface FeedbackRepository extends JpaRepository<Feedback, Long> {

    // 피드백 타입에 맞는 피드백을 랜덤으로 하나 추출
    @Query(value = "select * from feedback where feedback_type = :feedbackType order by rand() limit 1", nativeQuery = true)
    Feedback findByFeedbackTypeToRandom(String feedbackType);
}
