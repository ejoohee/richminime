package com.richminime.domain.item.service;

import com.richminime.domain.item.dto.ItemReqDto;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemSearchCondition;
import com.richminime.domain.item.dto.ItemUpdateReqDto;

import java.util.List;

public interface ItemService {

    // 1. 테마 전체 목록 조회
    // 2. 테마 상세 조회(미리보기)
    // 3. 테마 구매하기
    // 4. 테마 카테고리별 조회(확장)
    List<ItemResDto> findAllItem();
    ItemResDto findItem(Long itemId, String token);

    List<ItemResDto> findAllItemByCondition(ItemSearchCondition condition);

    // 5. 테마 등록
    // 6. 테마 삭제
    // 7. 테마 수정
    ItemResDto addItem(ItemReqDto itemReqDto, String token);
    void deleteItem(Long itemId, String token);
    ItemResDto updateItem(Long itemId, ItemUpdateReqDto itemReqDto, String token);

}
