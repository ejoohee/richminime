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

    // 테마 구매하기는 UserItemService에서,,,?
    // Long 반환해서 itemId를 반환해주면 그거를 유저아이템서비스에서 받아서 구현하면 될듯
    Long buyItem(Long itemId, String token); // 이름 add로하면 애매해서일단은..

    List<ItemResDto> findAllItemByCondition(ItemSearchCondition condition);


    // 5. 테마 등록
    // 6. 테마 삭제
    // 7. 테마 수정

    ItemResDto addItem(ItemReqDto itemReqDto, String token);
    void deleteItem(Long itemId, String token);
    ItemResDto updateItem(ItemUpdateReqDto itemReqDto, String token);

}
