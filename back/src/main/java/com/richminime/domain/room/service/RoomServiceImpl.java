package com.richminime.domain.room.service;

import com.richminime.domain.clothing.exception.ClothingNotFoundException;
import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.exception.ItemNotFoundException;
import com.richminime.domain.item.repository.ItemRepository;
import com.richminime.domain.room.domain.Room;
import com.richminime.domain.room.dto.RoomReqDto;
import com.richminime.domain.room.dto.RoomResDto;
import com.richminime.domain.room.exception.RoomItemNotFoundException;
import com.richminime.domain.room.exception.RoomNotFoundException;
import com.richminime.domain.room.exception.RoomUserNotFoundException;
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
                        .orElseThrow(() -> new RoomUserNotFoundException("유저 찾을 수 없음",404L))
                .getUserId();
    }
    @Override
    public RoomResDto findRoom() {
        Long loginUserId = findLoginUserId();
        Room room = roomRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new RoomNotFoundException("룸을 찾을 수 없음",404L));
        Item item = itemRepository
                .findByItemId(room.getItem().getItemId())
                .orElseThrow(() -> new RoomItemNotFoundException("아이템을 찾을 수 없음",404L));

        return RoomResDto.builder()
                .imgURL(item.getItemImg())
                .build();
    }

    @Override
    @Transactional
    public RoomResDto updateRoom(RoomReqDto dto) {

        Long loginUserId = findLoginUserId();
        Room room = roomRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new RoomNotFoundException("룸을 찾을 수 없음",404L));
        Item item;
        if(dto.getItemId() == room.getItem().getItemId()){  //갈아끼울 테마(Item)과 이미 착용하고 있는 테마가 같을 시 기본 테마 적용
            item = Item.builder().itemId(0L).build();
            room.chageItem(item);
            return RoomResDto.builder()
                    .imgURL("url 프론트에서 처리 바람")
                    .build();
        }

        item = itemRepository
                .findByItemId(dto.getItemId())
                .orElseThrow(() -> new RoomItemNotFoundException("아이템을 찾을 수 없음",404L));
        room.chageItem(item);   //dirty checking

        return RoomResDto.builder()
                .imgURL(item.getItemImg())
                .build();
    }
}
