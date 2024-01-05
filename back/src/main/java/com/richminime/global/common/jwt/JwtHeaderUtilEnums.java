package com.richminime.global.common.jwt;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum JwtHeaderUtilEnums {

    AUTHORIZATION("Authorization 헤더 ", "Authorization"),
    GRANT_TYPE("JWT 타입 / Bearer ", "Bearer ");

    private String description;
    private String value;

}