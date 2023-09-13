package com.richminime.domain.user.domain;


import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.util.Date;

@Getter
@DynamicInsert
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Integer userId;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(length = 20, nullable = false)
    private String nickname;


    @Column(columnDefinition = "long default 0")
    private long balance;

    @Column(nullable = false)
    private String connectedId;

    @Column(length = 4, nullable = false)
    private String organizationCode;

    @Column(length = 20, nullable = false)
    private String cardNumber;

    @Column(nullable = false)
    private String userType;

    @Column(nullable = false)
    private Date birthDate;

    @Builder
    public User(String email, String password, String nickname, String connectedId, String organizationCode, String cardNumber, String userType, Date birthDate) {
        this.email = email;
        this.password = password;
        this.nickname = nickname;
        this.connectedId = connectedId;
        this.organizationCode = organizationCode;
        this.cardNumber = cardNumber;
        this.userType = userType;
        this.birthDate = birthDate;
    }


}
