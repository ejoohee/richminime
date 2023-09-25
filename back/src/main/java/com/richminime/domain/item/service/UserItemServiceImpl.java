package com.richminime.domain.item.service;

import com.richminime.domain.bankBook.dao.BankBookRepository;
import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.domain.ItemType;
import com.richminime.domain.item.domain.UserItem;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemSearchCondition;
import com.richminime.domain.item.dto.UserItemResDto;
import com.richminime.domain.item.repository.ItemRepository;
import com.richminime.domain.item.repository.UserItemRepository;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.domain.UserType;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import javax.transaction.Transactional;
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
    private final ItemRepository itemRepository;
    private final UserRepository userRepository;
    private final BankBookRepository bankBookRepository;
    private final SecurityUtils securityUtils;



    /**
     * 로그인 유저가 관리자인지 확인하는 메서드
     * 관리자면 true 반환 / 일반회원이면 false 반환
     */
    public boolean isAdmin() {

        String loginUserEmail = securityUtils.getLoggedInUserEmail();

        User loginUser = userRepository.findByEmail(loginUserEmail)
                .orElseThrow(() -> {
                    log.error("[테마 상점 테마 등록] 로그인 유저를 찾을 수 없습니다.");
                    return new ResponseStatusException(HttpStatus.NOT_FOUND, "로그인 유저를 찾을 수 없습니다.");
                });

        if(loginUser.getUserType().equals(UserType.ROLE_ADMIN))
            return true;

        return false;
    }

    /**
     * 소유한 테마 전체 조회
     * @param userId
     * @return
     */
    @Transactional
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
     * @return
     */
    @Transactional
    @Override
    public UserItemResDto findUserItem(Long itemId) {
        log.info("[소유한 테마 상세 조회] 사용자가 선택한 소유테마 상세 조회 요청. itemId : {}", itemId);


        return null;
    }

    /**
     * 소유한 테마 카테고리별 조회
     * @param itemType
     * @return
     */
    @Transactional
    @Override
    public List<UserItemResDto> findAllUserItemByType(ItemType itemType) {
        if(itemType == null) {
            List<UserItem> userItemList = userItemRepository.findAll();

        }

        return null;
    }

    /**
     * 소유한 테마 적용/해제하기
     * 로그인 사용자가 소유한 테마 중 선택한 테마를 적용/해제 합니다.
     * 기적용된 테마 번호(itemId)가 다를 경우 적용 / 같을 경우 해제
     * @param itemId
     * @return
     */
    @Transactional
    @Override
    public Optional<UserItemResDto> updateUserItem(Long itemId) {
        return Optional.empty();
    }

    /**
     * 소유하지 않은 테마 구매하기
     * @param itemId
     * @return
     */
    @Transactional
    @Override
    public UserItemResDto addUserItem(Long itemId) {

        // 유저찾기 추가

        Item item = itemRepository.findItemByItemId(itemId)
                .orElseThrow(() -> {
                    log.error("[테마 구매하기] 테마를 찾을 수 없습니다.");
                    return new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 테마를 찾을 수 없습니다.");
                });

        // 보유하고 있는 테마인지 확인


        // 잔액 확인


        // 소유물건이 20개인지 확인
        // 유저카운트 ++


        return null;
    }

    /**
     * 소유한 테마 판매하기
     * @param userItemId
     */
    @Transactional
    @Override
    public void deleteUserItem(Long userItemId) {

    }

}
