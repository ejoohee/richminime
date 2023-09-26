package com.richminime.domain.character.service;

import com.richminime.domain.character.dto.CharacterResDto;

import java.util.List;

public interface CharacterService {


    CharacterResDto find();

    public List<CharacterResDto> update(Long characterId);


}
