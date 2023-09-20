package com.richminime.domain.gpt.domain;

import com.richminime.domain.user.domain.User;

import javax.persistence.*;

@Entity
public class Prompt {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "prompt_id")
    private Long prompt_id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "role", nullable = false)
    private String role;

    @Column(name = "content", nullable = false)
    private String content;


}
