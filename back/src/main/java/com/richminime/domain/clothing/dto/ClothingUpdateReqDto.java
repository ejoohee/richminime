package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.constant.ClothingType;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ClothingUpdateReqDto {

    private Long clothingId;
    private String clothingName;
    private ClothingType clothingType;
    private String clothingImg;
    private String clothingApplyImg;
    private String clothingInfo;
    private long price;

}
