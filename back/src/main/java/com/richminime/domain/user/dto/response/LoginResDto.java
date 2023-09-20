package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginResDto {

    private String accessToken;

    private String nickname;

    private Long balance;

    @Builder
    public LoginResDto(String accessToken, String nickname, Long balance) {
        this.accessToken = accessToken;
        this.nickname = nickname;
        this.balance = balance;
    }

}
