package com.richminime.domain.room.service;

import com.richminime.domain.character.dto.CharacterResDto;
import com.richminime.domain.room.dto.RoomReqDto;
import com.richminime.domain.room.dto.RoomResDto;

public interface RoomService {


    RoomResDto findRoom();

    RoomResDto updateRoom(RoomReqDto dto);


}
