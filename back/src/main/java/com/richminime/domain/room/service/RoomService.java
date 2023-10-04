package com.richminime.domain.room.service;

import com.richminime.domain.character.dto.CharacterResDto;
import com.richminime.domain.room.dto.RoomReqDto;
import com.richminime.domain.room.dto.RoomResDto;

import java.util.List;

public interface RoomService {


    List<RoomResDto> findRoom();

    RoomResDto updateRoom(RoomReqDto dto);


}
