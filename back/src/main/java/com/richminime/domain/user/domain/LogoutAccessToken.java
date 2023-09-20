package com.richminime.domain.user.domain;

import lombok.Builder;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

<<<<<<< HEAD:back/src/main/java/com/richminime/domain/user/domain/LogOutAccessToken.java
=======

>>>>>>> b529402fe4cc836a663dbfc21051add129d59a43:back/src/main/java/com/richminime/domain/user/domain/LogoutAccessToken.java
@Getter
@RedisHash("logoutAccessToken")
public class LogoutAccessToken {

    @Id
    private String email;

    private String accessToken;

    @TimeToLive
    private Long expiration;

    @Builder
    public LogoutAccessToken(String email, String accessToken, Long expiration) {
        this.email = email;
        this.accessToken = accessToken;
        this.expiration = expiration;
    }

}
