package com.richminime.domain.user.dto.request;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Builder
public class UpdatePasswordReqDto {

    private String password;

}
