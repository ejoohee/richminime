package com.richminime.domain.item.service;

import com.richminime.domain.item.domain.ItemType;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemSearchCondition;
import com.richminime.domain.item.dto.UserItemResDto;
import com.richminime.domain.item.repository.UserItemRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserItemServiceImpl implements UserItemService {

    /*
    userItemId
    items
    user
     */

    private final UserItemRepository userItemRepository;

    /**
     * 소유한 테마 전체 조회
     * @param userId
     * @return
     */
    @Override
    public List<UserItemResDto> findAllUserItem(Long userId) {
        log.info("[소유한 테마 전체 조회] 사용자가 소유한 테마 전체 조회, userId : {}", userId);

        return userItemRepository.findAllByUserId(userId).stream()
                .map(userItem -> UserItemResDto.entityToDto(userItem))
                .collect(Collectors.toList());
    }

    /**
     * 소유한 테마 상세 조회
     * @param itemId
     * @param token
     * @return
     */
    @Override
    public UserItemResDto findUserItem(Long itemId, String token) {
        return null;
    }

    /**
     * 소유한 테마 카테고리별 조회
     * @param itemType
     * @param token
     * @return
     */
    @Override
    public List<UserItemResDto> findAllUserItemByType(ItemType itemType, String token) {
        return null;
    }

    /**
     * 소유한 테마 적용/해제하기
     * 로그인 사용자가 소유한 테마 중 선택한 테마를 적용/해제 합니다.
     * 기적용된 테마 번호(itemId)가 다를 경우 적용 / 같을 경우 해제
     * @param itemId
     * @param token
     * @return
     */
    @Override
    public Optional<UserItemResDto> updateUserItem(Long itemId, String token) {
        return Optional.empty();
    }

    /**
     * 소유하지 않은 테마 구매하기
     * @param itemId
     * @param token
     * @return
     */
    @Override
    public UserItemResDto addUserItem(Long itemId, String token) {
        return null;
    }

    /**
     * 소유한 테마 판매하기
     * @param userItemId
     * @param token
     */
    @Override
    public void deleteUserItem(Long userItemId, String token) {

    }

}
