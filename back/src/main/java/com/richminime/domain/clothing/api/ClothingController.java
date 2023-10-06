package com.richminime.domain.clothing.api;


import com.richminime.domain.clothing.constant.ClothingResponseMessage;
import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dto.*;
import com.richminime.domain.clothing.service.ClothingService;
import com.richminime.domain.clothing.service.UserClothingService;
import com.richminime.global.dto.MessageDto;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RequiredArgsConstructor
@RequestMapping("/clothing")
@RestController
public class ClothingController {
    private final ClothingService clothingService;
    private final UserClothingService userClothingService;

    //관리자 등록
    @Operation(
            summary = "옷 상점에 옷 등록하기",
            description = "관리자 사용자가 옷 상점에 새로운 옷을 등록합니다."
    )
    @PostMapping("")
    public ResponseEntity<ClothingResDto> addClothing(@RequestBody @Valid ClothingReqDto clothingReqDto) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(clothingService.addClothing(clothingReqDto));
    }

    //유저 구매
    @Operation(
            summary = "로그인 사용자가 소유한 옷 구매하기",
            description = "소유한 테마 중 선택한 옷을 구매합니다."
    )
    @PostMapping("/my")
    public ResponseEntity<AddUserClothingResDto> addMyClothing(@RequestParam(required = true) Long clothingId) {
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(userClothingService.addMyClothing(clothingId));
    }

    //관리자 수정
    @Operation(
            summary = "옷 상점에 옷 수정하기",
            description = "관리자 사용자가 옷 상점에 등록된 옷을 수정합니다."
    )
    @PutMapping("")
    public ResponseEntity<ClothingResDto> updateClothing(@RequestBody @Valid ClothingUpdateReqDto clothingUpdateReqDto) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(clothingService.updateClothing(clothingUpdateReqDto));
    }

    //관리자 삭제
    @Operation(
            summary = "옷 상점에 옷 삭제하기",
            description = "관리자 사용자가 옷 상점에 등록된 옷을 삭제합니다."
    )
    @DeleteMapping("/{clothingId}")
    public ResponseEntity<MessageDto> deleteClothing(@PathVariable("clothingId") Long clothingId) {
        clothingService.deleteClothing(clothingId);
        return ResponseEntity.status(HttpStatus.OK).body(MessageDto.msg(
                ClothingResponseMessage.DELETE_CLOTHING.getMessage()
        ));
    }

    //유저 판매
    @Operation(
            summary = "로그인 사용자가 소유한 옷 판매하기",
            description = "소유한 테마 중 선택한 옷을 판매합니다."
    )
    @DeleteMapping("/my/{userClothingId}")
    public ResponseEntity<DeleteUserClothingResDto> deleteMyClothing(@PathVariable("userClothingId") Long userClothingId) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(userClothingService.deleteMyClothing(userClothingId));
    }

    //상점 상세보기
    @Operation(
            summary = "옷 상점에 등록된 옷 상세 조회",
            description = "옷 상점에 등록된 옷 중 선택한 옷을 상세 조회합니다."
    )
    @GetMapping("/{clothingId}")
    public ResponseEntity<ClothingResDto> findOneClothing(@PathVariable Long clothingId) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(clothingService.findOneClothing(clothingId));
    }

    //상점 타입별 전체보기
    @Operation(
            summary = "옷 상점에 등록된 옷 전체 또는 카테고리별 조회",
            description = "선택한 방법으로 옷 리스트를 조회합니다."
    )
    @GetMapping("")
    public ResponseEntity<List<ClothingResDto>> findAllClothingByType(@RequestParam(required = false) ClothingType clothingType) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(clothingService.findAllClothingByType(clothingType));
    }

    //유저 소유 옷 타입별 전체보기
    @Operation(
            summary = "로그인 사용자가 소유한 옷 전체 또는 카테고리별 조회",
            description = "선택한 방법으로 옷 리스트를 조회합니다."
    )
    @GetMapping("/my")
    public ResponseEntity<List<UserClothingResDto>> findAllMyClothingByType(@RequestParam(required = false) ClothingType clothingType) {
        return ResponseEntity.status(HttpStatus.OK)
                .body(userClothingService.findAllMyClothingByTypeExcludingId(clothingType));
    }
}
