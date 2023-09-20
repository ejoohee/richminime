package com.richminime.domain.user.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LoginReqDto {

    private String email;

    private String password;

}
