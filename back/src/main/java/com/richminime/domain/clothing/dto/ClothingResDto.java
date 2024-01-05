package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.domain.Clothing;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ClothingResDto {

    private final Long clothingId;
    private final String clothingName;
    private final String clothingType;
    private final String clothingImg;
    private final String clothingApplyImg;
    private final String clothingInfo;
    private final long price;

    public static ClothingResDto entityToDto(Clothing clothing) {
        return ClothingResDto.builder()
                .clothingId(clothing.getClothingId())
                .clothingName(clothing.getClothingName())
                .clothingType(clothing.getClothingType().getValue())
                .clothingImg(clothing.getClothingImg())
                .clothingApplyImg(clothing.getClothingApplyImg())
                .clothingInfo(clothing.getClothingInfo())
                .price(clothing.getPrice())
                .build();
    }
}