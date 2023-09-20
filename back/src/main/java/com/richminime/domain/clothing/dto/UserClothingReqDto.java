package com.richminime.domain.clothing.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserClothingReqDto {

    private Long clothingId;
    private Long userId;

}
