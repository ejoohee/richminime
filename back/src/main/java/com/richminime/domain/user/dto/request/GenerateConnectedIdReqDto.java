package com.richminime.domain.user.dto.request;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GenerateConnectedIdReqDto {

    private String id;

    private String password;

    private String organization;


}
