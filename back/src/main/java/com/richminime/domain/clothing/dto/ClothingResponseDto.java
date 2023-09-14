package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.clothing.domain.UserClothing;
import lombok.Builder;
import lombok.Getter;

public class ClothingResponseDto {

    @Getter
    public static class ClothingInfoResponseDto {
        private final Long clothingId;
        private final String clothingName;
        private final ClothingType clothingType;
        private final String clothingImg;
        private final String clothingInfo;
        private final Long price;

        @Builder
        public ClothingInfoResponseDto(Clothing clothing) {
            this.clothingId = clothing.getClothingId();
            this.clothingName = clothing.getClothingName();
            this.clothingType = clothing.getClothingType();
            this.clothingImg = clothing.getClothingImg();
            this.clothingInfo = clothing.getClothingInfo();
            this.price = clothing.getPrice();
        }
    }

    @Getter
    public static class UserClothingInfoResponseDto {
        private final Long userClothingId;
        private final Long clothingId;
        private final ClothingType clothingType;
        private final String clothingImg;
        private final String clothingInfo;
        private final String clothingName;
        private final Long price;

        @Builder
        public UserClothingInfoResponseDto(UserClothing userclothing) {
            this.userClothingId = userclothing.getUserClothingId();
            this.clothingId = userclothing.getClothing().getClothingId();
            this.clothingType = userclothing.getClothing().getClothingType();
            this.clothingImg = userclothing.getClothing().getClothingImg();
            this.clothingInfo = userclothing.getClothing().getClothingInfo();
            this.clothingName = userclothing.getClothing().getClothingName();
            this.price = userclothing.getClothing().getPrice();
        }
    }
}
