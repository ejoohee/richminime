package com.richminime.domain.item.service;

import com.richminime.domain.item.domain.ItemType;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemSearchCondition;
import com.richminime.domain.item.dto.UserItemResDto;

import java.util.List;
import java.util.Optional;

public interface UserItemService {
    // 1. 소유한 테마 전체 조회
    List<UserItemResDto> findAllUserItem(String token);

    // 3. 소유한 테마 상세 조회
    UserItemResDto findUserItem(String token, Long userItemId);

    // 소유한 테마 카테고리별 조회
    List<UserItemResDto> findAllUserItemByType(String token, ItemType itemType);

    // 5-1. 소유한 테마 적용하기
    // 5-2. 소유한 테마 벗기기
//    UserItemResDto updateUserItem(Long userItemId);

    // 소유하지 않은 테마 구매하기
    UserItemResDto addUserItem(String token, Long itemId);

    // 6. 소유한 테마 판매하기
    void deleteUserItem(String token, Long userItemId);

    // 2. 소유한 테마 조건별 조회(확장)
//    List<UserItemResDto> findAllUserItemByCondition(ItemSearchCondition condition, String token);

}
