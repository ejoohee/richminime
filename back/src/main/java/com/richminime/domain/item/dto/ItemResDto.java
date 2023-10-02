package com.richminime.domain.item.dto;

import com.richminime.domain.item.domain.Item;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ItemResDto {

    private Long itemId;
    private String itemName;
    private String itemType;
    private String itemImg;
    private String itemInfo;
    private Long price;

    public static ItemResDto entityToDto(Item item) {
        return ItemResDto.builder()
                .itemId(item.getItemId())
                .itemName(item.getItemName())
                .itemType(item.getItemType().getValue())
                .itemImg(item.getItemImg())
                .itemInfo(item.getItemInfo())
                .price(item.getPrice())
                .build();
    }

}
