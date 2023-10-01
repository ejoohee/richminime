package com.richminime.domain.item.service;

import com.richminime.domain.item.constant.ItemType;
import com.richminime.domain.item.dto.AddUserItemResDto;
import com.richminime.domain.item.dto.DeleteUserItemResDto;
import com.richminime.domain.item.dto.UserItemResDto;

import java.util.List;

public interface UserItemService {
    // 1. 소유한 테마 전체 조회
    List<UserItemResDto> findAllUserItem(String token);

    // 3. 소유한 테마 상세 조회
    UserItemResDto findUserItem(String token, Long userItemId);

    // 소유한 테마 카테고리별 조회
    List<UserItemResDto> findAllUserItemByType(String token, ItemType itemType);

    // 소유하지 않은 테마 구매하기
    AddUserItemResDto addUserItem(String token, Long itemId);

    // 6. 소유한 테마 판매하기
    DeleteUserItemResDto deleteUserItem(String token, Long userItemId);

}
