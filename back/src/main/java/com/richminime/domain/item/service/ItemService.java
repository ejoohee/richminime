package com.richminime.domain.item.service;

import com.richminime.domain.item.constant.ItemType;
import com.richminime.domain.item.dto.ItemReqDto;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemUpdateReqDto;

import java.util.List;

public interface ItemService {

    List<ItemResDto> findAllItem();

    ItemResDto findItem(Long itemId);

    List<ItemResDto> findAllItemByType(ItemType itemType);

    ItemResDto addItem(String token, ItemReqDto itemReqDto);

    void deleteItem(String token, Long itemId);

    ItemResDto updateItem(String token, Long itemId, ItemUpdateReqDto itemReqDto);

}
