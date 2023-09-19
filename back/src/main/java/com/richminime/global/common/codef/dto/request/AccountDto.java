package com.richminime.global.common.codef.dto.request;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AccountDto {

    private String countryCode;

    private String businessType;

    private String clientType;

    private String organization;

    private String loginType;

    private String id;

    private String password;

    @Builder
    public AccountDto(String organization, String id, String password) {
        // 기본값 설정
        this.countryCode = "KR";
        this.businessType = "CD";
        this.clientType = "P";
        this.organization = organization;
        this.loginType = "1";
        this.id = id;
        this.password = password;
    }

}
