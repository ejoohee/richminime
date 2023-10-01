package com.richminime.global.common.codef.dto.request;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class FindCardListReqDto {

    private String organization;

    private String connectedId;

    private String cardNo;

    private String cardPassword;

    private String birthDate;

    private String inquiryType;

}
