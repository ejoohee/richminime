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

import java.util.List;
import java.util.stream.Collectors;


@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements RoomService {

    private final RoomRepository roomRepository;
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;
    private final SecurityUtils securityUtils;


    public Long findLoginUserId() {
        return userRepository.findByEmail(securityUtils.getLoggedInUserEmail())
                .orElseThrow(() -> new RoomUserNotFoundException("유저 찾을 수 없음", 404L))
                .getUserId();
    }

    @Override
    public List<RoomResDto> findRoom() {
        Long loginUserId = findLoginUserId();
        List<Room> rooms = roomRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new RoomNotFoundException("룸을 찾을 수 없음", 404L));
        return rooms.stream()
                .map(room -> {
                    Item item = itemRepository
                            .findByItemId(room.getItem().getItemId())
                            .orElseThrow(() -> new RoomItemNotFoundException("아이템을 찾을 수 없음", 404L));

                    return RoomResDto.builder()
                            .itemId(item.getItemId())
                            .imgURL(item.getItemImg())
                            .itemType(item.getItemType().getValue())
                            .build();
                })
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public RoomResDto updateRoom(RoomReqDto dto) {

        Long loginUserId = findLoginUserId();
        List<Room> rooms = roomRepository
                .findByUserId(loginUserId)
                .orElseThrow(() -> new RoomNotFoundException("룸을 찾을 수 없음", 404L));
        Item item = itemRepository.getById(dto.getItemId());

        for (Room room : rooms) {
            if (item.getItemType().equals(room.getItem().getItemType())) {       //요청한 타입이 같고
                if (item.getItemId() != room.getItem().getItemId()) {             //아이디가 다르면
                    room.chageItem(Item.builder().itemId(dto.getItemId()).build());           //room의 정보를 업데이트
                    return RoomResDto.builder()
                            .itemId(item.getItemId())
                            .imgURL(item.getItemImg())
                            .itemType(item.getItemType().getValue())
                            .build();
                } else {                                       //아이디가 같으면 ->  기본 셋팅으로
                    if(item.getItemType().equals("벽지장판")){
                        room.chageItem(Item.builder().itemId(100000L).build());
                    } else if (item.getItemType().equals("가구")) {
                        room.chageItem(Item.builder().itemId(100001L).build());
                    } else if (item.getItemType().equals("러그")) {
                        room.chageItem(Item.builder().itemId(100002L).build());
                    }
                    return RoomResDto.builder()
                            .itemId(room.getItem().getItemId())
                            .imgURL("defaultData")
                            .itemType("defaultData")
                            .build();
                }
            }
        }
        return null;
    }
}
