package com.richminime.domain.character.service;

import com.richminime.domain.character.dto.CharacterResDto;
import com.richminime.domain.character.repository.CharacterRepository;
import com.richminime.global.util.jwt.JWTUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class CharacterServiceImpl implements CharacterService{

    private final JWTUtil jwtUtil;
    private final CharacterRepository characterRepository;


    @Override
    public CharacterResDto find() {
        jwtUtil.getUserNo();
        return ;
    }

    @Override
    @Transactional
    public List<CharacterResDto> update(Long characterId) {


        return new ArrayList<>();
    }
}
