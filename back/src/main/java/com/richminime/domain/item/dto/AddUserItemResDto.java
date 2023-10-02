package com.richminime.domain.item.dto;

import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.domain.UserItem;
import com.richminime.domain.user.domain.User;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AddUserItemResDto {

    // 아이템 구매 후 나의 잔액도 표시되게 Dto 추가
    private Long userId;
    private Long itemId;
    private String itemName;
    private String itemType;
    private String itemImg;
    private String itemInfo;
    private Long price;
    private Long balance;

    public static AddUserItemResDto entityToDto(UserItem userItem) {
        Item item = userItem.getItem();
        User user = userItem.getUser();

        return AddUserItemResDto.builder()
                .userId(user.getUserId())
                .itemId(item.getItemId())
                .itemName(item.getItemName())
                .itemType(item.getItemType().getValue())
                .itemImg(item.getItemImg())
                .itemInfo(item.getItemInfo())
                .price(item.getPrice())
                .balance(user.getBalance())
                .build();
    }

}
