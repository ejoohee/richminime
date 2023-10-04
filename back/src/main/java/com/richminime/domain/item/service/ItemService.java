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

    ItemResDto addItem(ItemReqDto itemReqDto);

    void deleteItem(Long itemId);

    ItemResDto updateItem(Long itemId, ItemUpdateReqDto itemReqDto);

}
