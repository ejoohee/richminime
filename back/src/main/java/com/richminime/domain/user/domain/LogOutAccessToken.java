package com.richminime.domain.user.domain;

import lombok.Builder;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

@Getter
@RedisHash("refreshToken")
public class LogOutAccessToken {

    @Id
    private String email;

    private String accessToken;

    @TimeToLive
    private Long expiration;

    @Builder
    public LogOutAccessToken(String email, String accessToken, Long expiration) {
        this.email = email;
        this.accessToken = accessToken;
        this.expiration = expiration;
    }

}
