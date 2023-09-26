package com.richminime.domain.character.service;

import com.richminime.domain.character.domain.Character;
import com.richminime.domain.character.dto.CharacterResDto;
import com.richminime.domain.character.repository.CharacterRepository;
import com.richminime.domain.clothing.dao.ClothingRepository;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.item.service.UserItemService;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.config.SecurityConfig;
import com.richminime.global.exception.NotFoundException;
import com.richminime.global.util.SecurityUtils;
import com.richminime.global.util.jwt.JWTUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;


@Service
@RequiredArgsConstructor
public class CharacterServiceImpl implements CharacterService{

    private final CharacterRepository characterRepository;
    private final UserRepository userRepository;
    private final ClothingRepository clothingRepository;
    private final SecurityUtils securityUtils;


    public Long findLoginUserId(){
        return userRepository.findByEmail(securityUtils.getLoggedInUserEmail())
                        .orElseThrow(() -> new NotFoundException("유저 찾을 수 없음"))
                .getUserId();
    }
    @Override
    public CharacterResDto find() {
        Long loginUserId = findLoginUserId();
        Character character = characterRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new NotFoundException("캐릭터를 찾을 수 없음"));  //로그인 정보 기반으로 캐릭터 찾음
        Clothing clothing = clothingRepository
                .findByclothingId(character.getCharacterId())         //찾은 캐릭터 정보 기반으로 clothing에서 이미지 서치
                .orElseThrow(() -> new NotFoundException("옷을 찾을 수 없음"));

        return CharacterResDto.builder()
                .characterId(character.getCharacterId())
                .imgURL(clothing.getClothingImg())
                .build();
    }

    @Override
    @Transactional
    public CharacterResDto update(Long clothingId) {
        Long loginUserId = findLoginUserId();
        Character character = characterRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new NotFoundException("캐릭터를 찾을 수 없음"));

        character.chageClothing(Clothing.builder().clothingId(clothingId).build());   //dirty checking

        Clothing clothing = clothingRepository       //바뀐 clothingId를 기반으로 이미지 서치
                .findByclothingId(clothingId)
                .orElseThrow(() -> new NotFoundException("옷을 찾을 수 없음"));
        return CharacterResDto.builder()
                .characterId(character.getCharacterId())
                .imgURL(clothing.getClothingImg())
                .build();
    }
}
