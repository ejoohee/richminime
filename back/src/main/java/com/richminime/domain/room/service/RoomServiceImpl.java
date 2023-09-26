package com.richminime.domain.room.service;

import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.repository.ItemRepository;
import com.richminime.domain.room.domain.Room;
import com.richminime.domain.room.dto.RoomResDto;
import com.richminime.domain.room.repository.RoomRepository;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.exception.NotFoundException;
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
                        .orElseThrow(() -> new NotFoundException("유저 찾을 수 없음"))
                .getUserId();
    }
    @Override
    public RoomResDto find() {
        Long loginUserId = findLoginUserId();
        Room room = roomRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new NotFoundException("룸을 찾을 수 없음"));
        Item item = itemRepository
                .findByItemId(room.getItem().getItemId())
                .orElseThrow(() -> new NotFoundException("옷을 찾을 수 없음"));

        return RoomResDto.builder()
                .roomId(room.getRoomId())
                .imgURL(item.getItemImg())
                .build();
    }

    @Override
    @Transactional
    public RoomResDto update(Long itemId) {

        Long loginUserId = findLoginUserId();
        Room room = roomRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new NotFoundException("룸을 찾을 수 없음"));
        room.chageItem(Item.builder().itemId(itemId).build());   //dirty checking
        Item item = itemRepository
                .findByItemId(room.getItem().getItemId())
                .orElseThrow(() -> new NotFoundException("옷을 찾을 수 없음"));

        return RoomResDto.builder()
                .roomId(room.getRoomId())
                .imgURL(item.getItemImg())
                .build();
    }
}
