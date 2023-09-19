package com.richminime.domain.user.dto.request;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GenerateConnectedIdRequest {

    private String id;

    private String password;

    private String organization;

    private String cardNumber;


}
