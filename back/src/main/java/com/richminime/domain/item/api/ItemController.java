package com.richminime.domain.item.api;

import com.richminime.domain.item.constant.ItemType;
import com.richminime.domain.item.dto.*;
import com.richminime.domain.item.service.ItemService;
import com.richminime.domain.item.service.UserItemService;
import com.richminime.global.dto.MessageDto;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/item")
public class ItemController {

    private final ItemService itemService;
    private final UserItemService userItemService;
//    private final String ACCESS_TOKEN = "AccessToken";

    @Operation(
            summary = "테마 상점에 등록된 테마 전체 또는 카테고리별 조회",
            description = "선택한 방법으로 테마 리스트를 조회합니다."
    )
    @GetMapping
    public ResponseEntity<List<ItemResDto>> findAllItemByCondition(@RequestParam(required = false) ItemType itemType) {
        return ResponseEntity.ok(itemService.findAllItemByType(itemType));
    }
    
    @Operation(
            summary = "테마 상점에 등록된 테마 상세 조회",
            description = "테마 상점에 등록된 테마 중 선택한 테마를 상세 조회합니다."
    )
    @GetMapping("/{itemId}")
    public ResponseEntity<ItemResDto> findItem(@PathVariable Long itemId) {
        return ResponseEntity.ok(itemService.findItem(itemId));
    }

    // 관리자 기능
    @Operation(
            summary = "테마 상점에 테마 등록하기",
            description = "관리자 사용자가 테마 상점에 새로운 테마를 등록합니다."
    )
    @PostMapping
    public ResponseEntity<ItemResDto> addItem(@RequestBody ItemReqDto itemReqDto) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(itemService.addItem(itemReqDto));
    }

    @Operation(
            summary = "테마 상점에 테마 삭제하기",
            description = "관리자 사용자가 테마 상점에 등록된 테마를 삭제합니다."
    )
    @DeleteMapping("/{itemId}")
    public ResponseEntity<MessageDto> deleteItem(@PathVariable Long itemId) {
        itemService.deleteItem(itemId);
        return ResponseEntity.ok(MessageDto.msg("DELETE SUCCESS"));
    }

    @Operation(
            summary = "테마 상점에 테마 수정하기",
            description = "관리자 사용자가 테마 상점에 등록된 테마를 수정합니다."
    )
    @PutMapping("/{itemId}")
    public ResponseEntity<ItemResDto> updateItem(@PathVariable Long itemId, @RequestBody ItemUpdateReqDto itemUpdateReqDto) {
        return ResponseEntity.ok(itemService.updateItem(itemId, itemUpdateReqDto));
    }

    // 유저별 기능
    @Operation (
            summary = "로그인 사용자가 소유한 테마 전체 또는 카테고리별 조회",
            description = "선택한 방법으로 테마 리스트를 조회합니다."
    )
    @GetMapping("/my")
    public ResponseEntity<List<UserItemResDto>> findAllUserItemByCondition(@RequestParam(required = false) ItemType itemType) {
        return ResponseEntity.ok(userItemService.findAllUserItemByType(itemType));
    }

    @Operation(
            summary = "로그인 사용자가 소유한 테마 상세 조회",
            description = "소유한 테마 중 선택한 테마를 상세 조회합니다."
    )
    @GetMapping("/my/{userItemId}")
    public ResponseEntity<UserItemResDto> findUserItem(@PathVariable Long userItemId) {
        return ResponseEntity.ok(userItemService.findUserItem(userItemId));
    }

    @Operation(
            summary = "로그인 사용자가 소유하지 않은 테마 구매하기",
            description = "테마 상점에서 선택한 테마를 구매합니다.(미소유 시)"
    )
    @PostMapping("/my/{itemId}")
    public ResponseEntity<AddUserItemResDto> addUserItem(@PathVariable Long itemId) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(userItemService.addUserItem(itemId));
    }

    @Operation(
            summary = "로그인 사용자가 소유한 테마 판매하기",
            description = "소유한 테마 중 선택한 테마를 판매합니다."
    )
    @DeleteMapping("/my/{itemId}")
    public ResponseEntity<DeleteUserItemResDto> deleteUserItem(@PathVariable Long itemId) {
        return ResponseEntity.ok(userItemService.deleteUserItem(itemId));
    }

}
