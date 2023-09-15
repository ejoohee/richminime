package com.richminime.domain.item.service;

import com.richminime.domain.item.dto.ItemReqDto;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemSearchCondition;
import com.richminime.domain.item.dto.ItemUpdateReqDto;
import com.richminime.domain.item.repository.ItemRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ItemServiceImpl implements ItemService {

    private final ItemRepository itemRepository;
    
    // 상점에 등록된 아이템 전체 조회
    @Override
    public List<ItemResDto> findAllItem() {
        return null;
    }

    @Override
    public ItemResDto findItem(Long itemId, String token) {
        return null;
    }

    @Override
    public Long buyItem(Long itemId, String token) {
        return null;
    }

    @Override
    public List<ItemResDto> findAllItemByCondition(ItemSearchCondition condition) {
        return null;
    }

    @Override
    public ItemResDto addItem(ItemReqDto itemReqDto, String token) {
        return null;
    }

    @Override
    public void deleteItem(Long itemId, String token) {

    }

    @Override
    public ItemResDto updateItem(ItemUpdateReqDto itemReqDto, String token) {
        return null;
    }
}
