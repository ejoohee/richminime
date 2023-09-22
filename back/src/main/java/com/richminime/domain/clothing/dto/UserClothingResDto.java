package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.domain.UserClothing;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserClothingResDto {
    private final Long userClothingId;
    private final Long userId;
    private final Long clothingId;
    private final ClothingType clothingType;
    private final String clothingImg;
    private final String clothingInfo;
    private final String clothingName;
    private final long price;

    public static UserClothingResDto entityToDto(UserClothing userClothing) {
        return UserClothingResDto.builder()
                .userClothingId(userClothing.getUserClothingId())
                .userId(userClothing.getUser().getUserId())
                .clothingName(userClothing.getClothing().getClothingName())
                .clothingType(userClothing.getClothing().getClothingType())
                .clothingImg(userClothing.getClothing().getClothingImg())
                .clothingInfo(userClothing.getClothing().getClothingImg())
                .price(userClothing.getClothing().getPrice())
                .build();
    }
}
