package com.richminime.domain.character.dto;

import com.richminime.domain.character.domain.Character;
import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.dto.ItemResDto;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CharacterResDto {

    private Long characterId;

    private String imgURL;


}
