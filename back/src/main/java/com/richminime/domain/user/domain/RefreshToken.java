package com.richminime.domain.user.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

import javax.persistence.Id;

@Getter
@RedisHash("refreshToken")
public class RefreshToken {

    @Id
    private String email;

    private String refreshToken;

    @TimeToLive
    private Long expiration;

    @Builder
    public RefreshToken(String email, String refreshToken, Long expiration) {
        this.email = email;
        this.refreshToken = refreshToken;
        this.expiration = expiration;
    }

}
