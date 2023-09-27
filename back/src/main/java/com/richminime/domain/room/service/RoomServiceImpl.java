package com.richminime.domain.room.service;

import com.richminime.domain.clothing.exception.ClothingNotFoundException;
import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.exception.ItemNotFoundException;
import com.richminime.domain.item.repository.ItemRepository;
import com.richminime.domain.room.domain.Room;
import com.richminime.domain.room.dto.RoomReqDto;
import com.richminime.domain.room.dto.RoomResDto;
import com.richminime.domain.room.exception.RoomNotFoundException;
import com.richminime.domain.room.repository.RoomRepository;
import com.richminime.domain.user.exception.UserNotFoundException;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements RoomService {

    private final RoomRepository roomRepository;
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;
    private final SecurityUtils securityUtils;


    public Long findLoginUserId(){
        return userRepository.findByEmail(securityUtils.getLoggedInUserEmail())
                        .orElseThrow(() -> new UserNotFoundException("유저 찾을 수 없음"))
                .getUserId();
    }
    @Override
    public RoomResDto findRoom() {
        Long loginUserId = findLoginUserId();
        Room room = roomRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new RoomNotFoundException("룸을 찾을 수 없음"));
        Item item = itemRepository
                .findByItemId(room.getItem().getItemId())
                .orElseThrow(() -> new ItemNotFoundException("아이템을 찾을 수 없음"));

        return RoomResDto.builder()
                .roomId(room.getRoomId())
                .imgURL(item.getItemImg())
                .build();
    }

    @Override
    @Transactional
    public RoomResDto updateRoom(RoomReqDto dto) {

        Long loginUserId = findLoginUserId();
        Room room = roomRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new RoomNotFoundException("룸을 찾을 수 없음"));
        Item item = itemRepository
                .findByItemId(dto.getItemId())
                .orElseThrow(() -> new ItemNotFoundException("아이템을 찾을 수 없음"));
        room.chageItem(item);   //dirty checking

        return RoomResDto.builder()
                .roomId(room.getRoomId())
                .imgURL(item.getItemImg())
                .build();
    }
}
