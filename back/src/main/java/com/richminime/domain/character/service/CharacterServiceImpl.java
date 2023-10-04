package com.richminime.domain.character.service;

import com.richminime.domain.character.domain.Character;
import com.richminime.domain.character.dto.CharacterReqDto;
import com.richminime.domain.character.dto.CharacterResDto;
import com.richminime.domain.character.exception.CharacterClothingNotFoundException;
import com.richminime.domain.character.exception.CharacterNotFoundException;
import com.richminime.domain.character.repository.CharacterRepository;
import com.richminime.domain.clothing.dao.ClothingRepository;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.clothing.exception.ClothingNotFoundException;
import com.richminime.domain.item.service.UserItemService;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.exception.UserNotFoundException;
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
                        .orElseThrow(() -> new CharacterNotFoundException("유저 찾을 수 없음",404L))
                .getUserId();
    }
    @Override
    public CharacterResDto findCharacter() {
        Long loginUserId = findLoginUserId();
        Character character = characterRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new CharacterNotFoundException("캐릭터를 찾을 수 없음",404L));  //로그인 정보 기반으로 캐릭터 찾음
        Clothing clothing = clothingRepository
                .findByclothingId(character.getCharacterId())         //찾은 캐릭터 정보 기반으로 clothing에서 이미지 서치
                .orElseThrow(() -> new CharacterClothingNotFoundException("옷을 찾을 수 없음",404L));

        return CharacterResDto.builder()
                .imgApplyURL(clothing.getClothingApplyImg())
                .build();
    }

    @Override
    @Transactional
    public CharacterResDto updateCharacter(CharacterReqDto dto) {
        Long loginUserId = findLoginUserId();
        Character character = characterRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new CharacterNotFoundException("캐릭터를 찾을 수 없음",404L));
        Clothing clothing;
        if(dto.getClothingId() == character.getClothing().getClothingId()){    //만약 입고있는 옷의 id와 요청한 옷의 id가 같으면 기본옷으로 교체
            clothing = Clothing.builder().clothingId(101L).build();
            character.chageClothing(clothing);
            return CharacterResDto.builder()
                    .imgApplyURL("https://richminime.s3.ap-northeast-2.amazonaws.com/clothing/0101팬티룩_착용.jpg")
                    .build();
        }


       clothing = clothingRepository       //바뀐 clothingId를 기반으로 이미지 서치
                .findByclothingId(dto.getClothingId())
                .orElseThrow(() -> new CharacterClothingNotFoundException("옷을 찾을 수 없음",404L));

        character.chageClothing(clothing);   //dirty checking

        return CharacterResDto.builder()
                .imgApplyURL(clothing.getClothingApplyImg())
                .build();
    }
}
