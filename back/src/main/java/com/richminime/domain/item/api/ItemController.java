package com.richminime.domain.item.api;

import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.domain.ItemType;
import com.richminime.domain.item.dto.ItemReqDto;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemUpdateReqDto;
import com.richminime.domain.item.service.ItemService;
import com.richminime.global.dto.MessageDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/item")
public class ItemController {

    private final String ACCESS_TOKEN = "AccessToken";
    private final ItemService itemService;

    @GetMapping
    // 테마 전체 목록 조회
    public ResponseEntity<List<ItemResDto>> findAllItem(@RequestHeader(ACCESS_TOKEN) String token) {
        return ResponseEntity.ok(itemService.findAllItem());
    }
    
    // 테마 상세 조회
    @GetMapping("/{itemId}")
    public ResponseEntity<ItemResDto> findItem(@PathVariable Long itemId, @RequestHeader(ACCESS_TOKEN) String token) {
        return ResponseEntity.ok(itemService.findItem(itemId, token));
    }
    
    // 테마 카테고리별 조회(확장)
//    @GetMapping
//    public ResponseEntity<List<ItemResDto>> findAllItemByType(@RequestParam(required = false) ItemType itemType, @RequestHeader(ACCESS_TOKEN) String token) {
//        return ResponseEntity.ok(itemService.findAllItemByType(itemType, token));
//    }

    // 관리자 기능
    // 테마 등록
    @PostMapping
    public ResponseEntity<ItemResDto> addItem(@RequestBody ItemReqDto itemReqDto, @RequestHeader(ACCESS_TOKEN) String token) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(itemService.addItem(itemReqDto, token));
    }

    // 관리자 기능
    // 테마 삭제
    @DeleteMapping("/{itemId}")
//    public ResponseEntity<ResponseDto<?>> deleteItem(@PathVariable Long itemId, @RequestHeader(ACCESS_TOKEN) String token){
//        itemService.deleteItem(itemId, token);
//        return ResponseEntity.ok(ResponseDto.create("DELETE SUCCESS"));
//    }
    public ResponseEntity<MessageDto> deleteItem(@PathVariable Long itemId, @RequestHeader(ACCESS_TOKEN) String token) {
        itemService.deleteItem(itemId, token);
        return ResponseEntity.ok(MessageDto.msg("DELETE SUCCESS"));
    }

    // 관리자 기능
    // 테마 수정
    @PutMapping("/{itemId}")
    public ResponseEntity<ItemResDto> updateItem(@PathVariable Long itemId, @RequestBody ItemUpdateReqDto itemUpdateReqDto, @RequestHeader(ACCESS_TOKEN) String token) {
        return ResponseEntity.ok(itemService.updateItem(itemId, itemUpdateReqDto, token));
    }


    // 유저별 기능
    // 소유한 테마 전체 조회
    // 소유한 테마 상세 조회
    // 소유한 테마 카테고리별 조회
    // 소유한 테마 적용하기, 벗기기
    // 소유하지 않은 테마 구매하기
    // 소유한 테마 판매하기
}
