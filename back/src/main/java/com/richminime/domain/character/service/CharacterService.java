package com.richminime.domain.character.service;

import com.richminime.domain.character.domain.Character;
import com.richminime.domain.character.dto.CharacterResDto;

import java.util.List;
import java.util.Optional;

public interface CharacterService {


    CharacterResDto find();

    CharacterResDto update(Long clothingId);


}
