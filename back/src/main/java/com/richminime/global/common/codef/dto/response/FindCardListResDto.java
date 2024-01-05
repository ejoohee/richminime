package com.richminime.global.common.codef.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class FindCardListResDto {

    private String resCardNo;

    private String resCardName;

    private String resCardType;

}
