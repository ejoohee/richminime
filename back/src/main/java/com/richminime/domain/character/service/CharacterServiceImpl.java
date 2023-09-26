package com.richminime.domain.character.service;

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



    @Override
    public String find() {
        return null;
    }

    @Override
    @Transactional
    public List<Long> update(Long characterId) {

        return new ArrayList<>();
    }
}
