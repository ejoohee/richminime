package com.richminime.domain.feedback.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

@Entity
@Getter
@Builder
@DynamicInsert
@NoArgsConstructor
@AllArgsConstructor
public class Feedback {

    @Id @GeneratedValue
    @Column(name = "feedback_id")
    private Long feedbackId;

    @Column(name = "feedback_type", columnDefinition = "varchar(50)")
    @Enumerated(EnumType.STRING)
    private FeedbackType feedbackType;

    @Column(name = "content", nullable = false)
    private String content;
}
