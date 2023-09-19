package com.richminime.domain.item.service;

import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemSearchCondition;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserItemServiceImpl implements UserItemService {

    /*
    userItemId
    items
    user
     */

    @Override
    public List<ItemResDto> findAllUserItem(String token) {
        return null;
    }

    @Override
    public ItemResDto findUserItem(Long itemId, String token) {
        return null;
    }

    @Override
    public Optional<ItemResDto> updateUserItem(Long itemId, String token) {
        return Optional.empty();
    }

    @Override
    public ItemResDto addUserItem(Long itemId, String token) {
        return null;
    }

    @Override
    public void deleteUserItem(Long userItemId, String token) {

    }

    @Override
    public List<ItemResDto> findAllUserItemByCondition(ItemSearchCondition condition, String token) {
        log.info("[소유한 테마 카테고리별 조회] 기능 확장 예정");

        return null;
    }
}
