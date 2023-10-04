package com.richminime.domain.clothing.dto;

import com.richminime.domain.clothing.domain.UserClothing;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DeleteUserClothingResDto {
    private long balance;
    private long sellPrice;

    public static DeleteUserClothingResDto entityToDto(UserClothing userClothing) {

        return DeleteUserClothingResDto.builder()
                .balance(userClothing.getUser().getBalance())
                .sellPrice(Math.round(userClothing.getClothing().getPrice() * 0.4))
                .build();
    }
}
