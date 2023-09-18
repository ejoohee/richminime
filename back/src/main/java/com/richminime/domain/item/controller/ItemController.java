package com.richminime.domain.item.controller;

import com.richminime.domain.item.dto.ItemReqDto;
import com.richminime.domain.item.dto.ItemResDto;
import com.richminime.domain.item.dto.ItemUpdateReqDto;
import com.richminime.domain.item.service.ItemService;
import com.richminime.global.dto.ResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/item")
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
    
    
    // 테마 구매
    
    
    // 테마 카테고리별 조회(확장)
    
    
    // 테마 등록
    @PostMapping
    public ResponseEntity<ItemResDto> addItem(@RequestBody ItemReqDto itemReqDto, @RequestHeader(ACCESS_TOKEN) String token) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(itemService.addItem(itemReqDto, token));
    }
    
    // 테마 삭제
    @DeleteMapping("/{itemId}")
    public ResponseEntity<ResponseDto<?>> deleteItem(@PathVariable Long itemId, @RequestHeader(ACCESS_TOKEN) String token){
        itemService.deleteItem(itemId, token);
        return ResponseEntity.ok(ResponseDto.create("DELETE SUCCESS"));
    }
    
    // 테마 수정
    @PutMapping("/{itemId}")
    public ResponseEntity<ItemResDto> updateItem(@PathVariable Long itemId, @RequestBody ItemUpdateReqDto itemUpdateReqDto, @RequestHeader(ACCESS_TOKEN) String token) {
        return ResponseEntity.ok(itemService.updateItem(itemId, itemUpdateReqDto, token));
    }



}
