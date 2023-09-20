package com.richminime.domain.user.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CheckEmailCodeReqDto {

    private String email;

    private String code;



}
