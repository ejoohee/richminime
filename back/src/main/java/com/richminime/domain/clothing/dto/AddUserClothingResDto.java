package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.domain.UserClothing;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AddUserClothingResDto {
    private final Long userClothingId;
    private final Long clothingId;
    private final String clothingType;
    private final String clothingImg;
    private final String clothingApplyImg;
    private final String clothingInfo;
    private final String clothingName;
    private final long price;
    private final long balance;

    public static AddUserClothingResDto entityToDto(UserClothing userClothing) {
        return AddUserClothingResDto.builder()
                .userClothingId(userClothing.getUserClothingId())
                .clothingId(userClothing.getClothing().getClothingId())
                .clothingName(userClothing.getClothing().getClothingName())
                .clothingType(userClothing.getClothing().getClothingType().getValue())
                .clothingImg(userClothing.getClothing().getClothingImg())
                .clothingApplyImg(userClothing.getClothing().getClothingApplyImg())
                .clothingInfo(userClothing.getClothing().getClothingImg())
                .price(userClothing.getClothing().getPrice())
                .balance(userClothing.getUser().getBalance())
                .build();
    }
}
