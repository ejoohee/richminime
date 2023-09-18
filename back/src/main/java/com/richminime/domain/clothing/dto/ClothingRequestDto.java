package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.clothing.domain.UserClothing;
import com.richminime.domain.user.domain.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

public class ClothingRequestDto {

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ClothingCreateRequestDto {
        private String clothingName;
        private ClothingType clothingType;
        private String clothingImg;
        private String clothingInfo;
        private Long price;

        public Clothing toCreateEntity() {
            return Clothing.builder()
                    .clothingName(this.clothingName)
                    .clothingType(this.clothingType)
                    .clothingImg(this.clothingImg)
                    .clothingInfo(this.clothingInfo)
                    .price(this.price)
                    .build();
        }
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ClothingUpdateRequestDto {
        private Long clothingId;
        private String clothingName;
        private ClothingType clothingType;
        private String clothingImg;
        private String clothingInfo;
        private Long price;

        public Clothing toUpdateEntity() {
            return Clothing.builder()
                    .clothingId(this.clothingId)
                    .clothingName(this.clothingName)
                    .clothingType(this.clothingType)
                    .clothingImg(this.clothingImg)
                    .clothingInfo(this.clothingInfo)
                    .price(this.price)
                    .build();
        }
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserClothingCreateRequestDto {

        private Long clothingId;
        private Long userId;

        public UserClothing toCreateEntity(Clothing clothing, User user) {
            return UserClothing.builder()
                    .clothing(clothing)
                    .user(user)
                    .build();
        }
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UserClothingUpdateRequestDto {

        private Long userClothingId;
        private Long clothingId;
        private Long userId;

        public UserClothing toUpdateEntity(Clothing clothing, User user) {
            return UserClothing.builder()
                    .userClothingId(this.userClothingId)
                    .clothing(clothing)
                    .user(user)
                    .build();
        }
    }
}