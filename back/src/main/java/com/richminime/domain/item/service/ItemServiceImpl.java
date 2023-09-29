package com.richminime.domain.item.service;

import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.constant.ItemType;
import com.richminime.domain.item.dto.ItemReqDto;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemUpdateReqDto;
import com.richminime.domain.item.exception.ItemNotFoundException;
import com.richminime.domain.item.repository.ItemRepository;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.domain.UserType;
import com.richminime.domain.user.exception.UserNotFoundException;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.util.SecurityUtils;
import com.richminime.global.util.jwt.JWTUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import javax.transaction.Transactional;
import java.util.List;
import java.util.stream.Collectors;

import static com.richminime.domain.item.constant.ItemExceptionMessage.*;
import static com.richminime.domain.user.exception.UserExceptionMessage.USER_NOT_FOUND;
import static com.richminime.global.constant.ExceptionMessage.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class ItemServiceImpl implements ItemService {

    private final ItemRepository itemRepository;
    private final UserRepository userRepository;
    private final SecurityUtils securityUtils;
    private final JWTUtil jwtUtil;

    /**
     * 상점에 등록된 아이템 전체 조회
     * 테마 상점에 등록된 아이템 전체를 조회합니다.
     * @return
     */
    @Transactional
    @Override
    public List<ItemResDto> findAllItem() {
        log.info("[테마 상점 전체 조회] 테마 상점에 등록된 테마 전체 조회");

        return itemRepository.findAll().stream()
                .map(item -> ItemResDto.entityToDto(item))
                .collect(Collectors.toList());
    }

    /**
     * 상점에 등록된 테마 카테고리별 조회
     * 사용자가 선택한 카테고리에 맞는 테마 리스트만 조회됩니다.
     * ※ 카테고리가 null일 경우, 전체 조회 메서드가 실행됩니다.
     * @param itemType
     * @return
     */
    @Transactional
    @Override
    public List<ItemResDto> findAllItemByType(ItemType itemType) {
        if(itemType == null)
            return findAllItem();

        log.info("[테마 상점 카테고리별 조회] 테마 카테고리별 조회");

        return itemRepository.findAllByItemType(itemType).stream()
                .map(item -> ItemResDto.entityToDto(item))
                .collect(Collectors.toList());
    }

    /**
     * 상점에 등록된 아이템 상세 조회
     * 사용자가 선택한 테마를 상세 조회하여 반환합니다.
     * 미리보기 기능이 활성화됩니다.
     * @param itemId
     * @return
     */
    @Transactional
    @Override
    public ItemResDto findItem(Long itemId) {
        log.info("[테마 상점 상세 조회] 테마 상점에 등록된 테마 상세 조회 요청. itemId : {}", itemId);

        Item item = itemRepository.findItemByItemId(itemId)
                .orElseThrow(() -> {
                    log.error("[테마 상점 상세 조회] 테마를 찾을 수 없습니다.");
                    return new ItemNotFoundException(ITEM_NOT_FOUND.getMessage());
                });

        log.info("[테마 상점 상세 조회] 테마 상세 조회 완료.");
        return ItemResDto.entityToDto(item);
    }

    /**
     * 로그인 유저가 관리자인지 확인하는 메서드
     * 관리자면 true 반환 / 일반회원이면 false 반환
     */
    public boolean isAdmin(String token) {
        String email = jwtUtil.getUsername(token);
        log.info("[아이템 서비스] email : {}", email);

        User loginUser = userRepository.findByEmail(email)
                .orElseThrow(() -> {
                    log.error("[아이템 서비스] 로그인 유저를 찾을 수 없습니다.");
                    return new UserNotFoundException(USER_NOT_FOUND.getMessage());
                });

        if(loginUser.getUserType().equals(UserType.ROLE_ADMIN))
            return true;

        return false;
    }

    /**
     * 테마 상점에 테마 등록
     * 로그인 유저가 관리자일 경우에만 등록 가능
     * @param itemReqDto
     * @return
     */
    @Transactional
    @Override
    public ItemResDto addItem(String token, ItemReqDto itemReqDto) {
        log.info("[테마 상점 테마 등록] 테마 상점에 새로운 테마 등록 요청");

        // 관리자 유저인지 확인
        if(!isAdmin(token)){
            log.error("[테마 상점 테마 등록] 관리자 회원만 테마를 등록할 수 있습니다.");
            throw new UserNotFoundException(AUTHORIZATION_FAILED.getMessage());
        }

        Item item = Item.builder()
                .itemName(itemReqDto.getItemName())
                .itemType(ItemType.getItemType(itemReqDto.getItemType()))
                .itemImg(itemReqDto.getItemImg())
                .itemInfo(itemReqDto.getItemInfo())
                .price(itemReqDto.getPrice())
                .build();

        itemRepository.save(item);

        log.info("[테마 상점 테마 등록] itemId : {}", item.getItemId());
        log.info("[테마 상점 테마 등록] 테마 등록 완료");

        return ItemResDto.entityToDto(item);
    }

    /**
     * 테마 상점에 등록된 테마 삭제
     * 로그인 유저가 관리자일 경우에만 삭제 가능
     * @param itemId
     */
    @Transactional
    @Override
    public void deleteItem(String token, Long itemId) {
        log.info("[테마 상점 테마 삭제] 테마 상점에 등록된 테마 삭제 요청. itemId : {}", itemId);
        
        // 관리자 유저인지 확인
        if(!isAdmin(token)){
            log.error("[테마 상점 테마 삭제] 관리자 회원만 테마를 삭제할 수 있습니다.");
            throw new UserNotFoundException(AUTHORIZATION_FAILED.getMessage());
        }
        
        Item item = itemRepository.findItemByItemId(itemId)
                .orElseThrow(() -> {
                    log.error("[테마 상점 테마 삭제] 테마를 찾을 수 없습니다.");
                    return new ItemNotFoundException(ITEM_NOT_FOUND.getMessage());
                });

        itemRepository.delete(item);
        log.info("[테마 상점 테마 삭제] 테마 상점에 등록된 테마 삭제 완료.");
    }

    /**
     * 테마 상점에 등록된 테마 정보 수정
     * 로그인 유저가 관리자일 경우에만 수정 가능
     * itemName, itemImg, itemInfo, price만 변경 가능합니다.(itemId, itemType은 변경 불가)
     * @param itemReqDto
     * @return
     */
    @Transactional
    @Override
    public ItemResDto updateItem(String token, Long itemId, ItemUpdateReqDto itemReqDto) {
        log.info("[테마 상점 테마 수정] 테마 상점에 등록된 테마 수정 요청. itemId : {}", itemId);

        // 관리자 유저 확인
        if(!isAdmin(token)){
            log.error("[테마 상점 테마 수정] 관리자 회원만 테마를 수정할 수 있습니다.");
            throw new UserNotFoundException(AUTHORIZATION_FAILED.getMessage());
        }
        
        Item item = itemRepository.findItemByItemId(itemId)
                .orElseThrow(() -> {
                    log.error("[테마 상점 테마 수정] 테마를 찾을 수 없습니다.");
                    return new ItemNotFoundException(ITEM_NOT_FOUND.getMessage());
                });

        item.updateItem(itemReqDto);
        itemRepository.save(item);

        log.info("[테마 상점 테마 수정] 테마 상점에 등록된 테마 수정 완료.");
        return ItemResDto.entityToDto(item);
    }
}
