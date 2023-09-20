package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.constant.ClothingType;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ClothingReqDto {

    private String clothingName;
    private ClothingType clothingType;
    private String clothingImg;
    private String clothingInfo;
    private Long price;

}
