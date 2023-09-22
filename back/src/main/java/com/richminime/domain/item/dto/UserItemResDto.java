package com.richminime.domain.item.dto;

import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.domain.UserItem;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class UserItemResDto {

    private Long userId;
    private Long itemId;
    private String itemName;
    private String itemType;
    private String itemImg;
    private String itemInfo;
    private Long price;

    public static UserItemResDto entityToDto(UserItem userItem) {
        Item item = userItem.getItem();

        return UserItemResDto.builder()
                .userId(userItem.getUser().getUserId())
                .itemId(item.getItemId())
                .itemName(item.getItemName())
                .itemType(item.getItemType().getValue())
                .itemImg(item.getItemImg())
                .itemInfo(item.getItemInfo())
                .build();
    }

}
