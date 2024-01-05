package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.constant.ClothingType;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ClothingReqDto {

    private String clothingName;
    private String clothingType;
    private String clothingImg;
    private String clothingApplyImg;
    private String clothingInfo;
    private long price;

}
