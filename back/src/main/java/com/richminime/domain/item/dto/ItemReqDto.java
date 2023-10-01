package com.richminime.domain.item.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ItemReqDto {

    String itemName;
    String itemType;
    String itemImg;
    String itemApplyImg;
    String itemInfo;
    Long price;

}
