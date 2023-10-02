package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class LoginResDto {

    private String accessToken;

    private String refreshToken;

    private String nickname;

    private Long balance;

}
