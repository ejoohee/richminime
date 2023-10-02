package com.richminime.global.common.jwt;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum JwtExpirationEnums {

    ACCESS_TOKEN_EXPIRATION_TIME("JWT 만료 시간 / 1분", 1000L * 60 * 1),
    REFRESH_TOKEN_EXPIRATION_TIME("Refresh 토큰 만료 시간 / 1일", 1000L * 60 * 60 * 24),
    REISSUE_EXPIRATION_TIME("Refresh 토큰 만료 시간 / 12시간", 1000L * 60 * 60 * 12);

    private String description;
    private Long value;

}