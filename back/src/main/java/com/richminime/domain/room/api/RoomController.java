package com.richminime.domain.room.api;

import com.richminime.domain.character.dto.CharacterResDto;
import com.richminime.domain.character.service.CharacterService;
import com.richminime.domain.room.dto.RoomResDto;
import com.richminime.domain.room.service.RoomService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/room")
@RequiredArgsConstructor
public class RoomController {

    private final RoomService roomService;
    @GetMapping
    public ResponseEntity<RoomResDto> find(){
        return ResponseEntity.ok(roomService.find());
    }
    @PutMapping
    public ResponseEntity<RoomResDto> update(@RequestBody Long itemId){
        return ResponseEntity.ok((roomService.update(itemId)));
    }

}
