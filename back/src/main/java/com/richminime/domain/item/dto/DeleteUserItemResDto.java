package com.richminime.domain.item.dto;

import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.domain.UserItem;
import com.richminime.domain.user.domain.User;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DeleteUserItemResDto {

    private Long userId;
    private Long balance; // 판매 후 잔액
    private Long sellPrice; // 팔린 금액

    public static DeleteUserItemResDto entityToDto(UserItem userItem) {
        User user = userItem.getUser();

        return DeleteUserItemResDto.builder()
                .userId(user.getUserId())
                .balance(user.getBalance())
                .sellPrice(Math.round(userItem.getItem().getPrice() * 0.4))
                .build();
    }

}
