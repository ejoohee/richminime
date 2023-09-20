package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class FindUserResDto {

    private String email;

    private String nickname;

    private Long balance;


}
