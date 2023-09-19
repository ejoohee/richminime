package com.richminime.global.common.codef.dto.response;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CodefOAuthResponse {

    private String access_token;

    private String token_type;

    private Integer expires_in;

    private String scope;

}
