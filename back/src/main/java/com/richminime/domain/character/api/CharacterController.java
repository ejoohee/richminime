package com.richminime.domain.character.api;

import com.richminime.domain.character.dto.CharacterResDto;
import com.richminime.domain.character.service.CharacterService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/character")
@RequiredArgsConstructor
public class CharacterController {

    private final CharacterService characterService;


    public ResponseEntity<CharacterResDto> find(){

    }

    public ResponseEntity<CharacterResDto> update(@RequestBody Long characterId){


        return
    }

}
