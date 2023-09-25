package com.richminime.domain.character.service;


import lombok.RequiredArgsConstructor;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@RequiredArgsConstructor
public class CharacterServiceImpl implements CharacterService{

    private final RedisTemplate redisTemplate;



    @Override
    public String find() {
        return null;
    }

    @Override
    public void update(String character) {

    }
}
