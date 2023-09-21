package com.richminime.domain.gpt.domain;

import com.richminime.domain.user.domain.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class Prompt {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "prompt_id")
    private Long promptId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "userId")
    private User user;


    /*
        role : 메시지를 보낸 주체로 3가지로 나뉜다
            system: 시스템 명령이나 설정. 이 역할은 주로 초기 설정이나 특별한 명령에 사용(EX Act as a Counselor).
            user: 사용자의 질문을 나타냄.  사용자가 무엇을 하고 싶은지, 무엇을 묻고 싶은지 등을 표현.
            assistant: 어시스턴트(GPT)의 응답. 일반적으로 이전 user 메시지에 대한 답변이나 반응.
     */
    @Column(name = "role_user", nullable = false)
    private String roleUser;

    @Column(name = "role_content", nullable = false)
    private String roleContent;

}
