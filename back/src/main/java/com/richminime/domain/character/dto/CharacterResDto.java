package com.richminime.domain.character.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class CharacterResDto {

    private Long characterId;

    private String imgURL;


}
