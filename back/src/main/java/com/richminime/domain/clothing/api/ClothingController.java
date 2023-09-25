package com.richminime.domain.clothing.api;


import com.richminime.domain.clothing.constant.ClothingResponseMessage;
import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dto.*;
import com.richminime.domain.clothing.service.ClothingService;
import com.richminime.domain.clothing.service.UserClothingService;
import com.richminime.global.dto.MessageDto;
import com.richminime.global.dto.ResponseDto;
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
    @PostMapping("")
    public ResponseEntity<MessageDto> addClothing(@RequestBody @Valid ClothingReqDto clothingReqDto) {
        clothingService.addClothing(clothingReqDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(MessageDto.msg(
                ClothingResponseMessage.ADD_CLOTHING.getMessage()
        ));
    }

    //유저 구매
    @PostMapping("/my")
    public ResponseEntity<MessageDto> addMyClothing(@RequestBody @Valid UserClothingReqDto userClothingReqDto) {
        userClothingService.addMyClothing(userClothingReqDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(MessageDto.msg(
                ClothingResponseMessage.ADD_MY_CLOTHING.getMessage()
        ));
    }

    //관리자 수정
    @PutMapping("")
    public ResponseEntity<ResponseDto<ClothingResDto>> updateClothing(@RequestBody @Valid ClothingUpdateReqDto clothingUpdateReqDto) {
        return ResponseEntity.status(HttpStatus.OK).body(
                ResponseDto.create(
                        ClothingResponseMessage.UPDATE_CLOTHING.getMessage(),
                        clothingService.updateClothing(clothingUpdateReqDto)
                )
        );
    }

    //관리자 삭제
    @DeleteMapping("/{clothingId}")
    public ResponseEntity<MessageDto> deleteClothing(@PathVariable("clothingId") Long clothingId) {
        clothingService.deleteClothing(clothingId);
        return ResponseEntity.status(HttpStatus.OK).body(MessageDto.msg(
                ClothingResponseMessage.DELETE_CLOTHING.getMessage()
        ));
    }

    //유저 판매
    @DeleteMapping("/my/{userClothingId}")
    public ResponseEntity<MessageDto> deleteMyClothing(@PathVariable("userClothingId") Long userClothingId) {
        userClothingService.deleteMyClothing(userClothingId);
        return ResponseEntity.status(HttpStatus.OK).body(MessageDto.msg(
                ClothingResponseMessage.DELETE_MY_CLOTHING.getMessage()
        ));
    }

    //상점 상세보기
    @GetMapping("/{clothingId}")
    public ResponseEntity<ResponseDto<ClothingResDto>> findOneClothing(@PathVariable Long clothingId) {
        return ResponseEntity.status(HttpStatus.OK).body(
                ResponseDto.create(
                        ClothingResponseMessage.FIND_ONE_CLOTHING.getMessage(),
                        clothingService.findOneClothing(clothingId)
                )
        );
    }

    //상점 타입별 전체보기
    @GetMapping("")
    public ResponseEntity<ResponseDto<List<ClothingResDto>>> findAllClothingByType(@RequestParam(required = false) ClothingType clothingType) {
        return ResponseEntity.status(HttpStatus.OK).body(
                ResponseDto.create(ClothingResponseMessage.FIND_ALL_CLOTHING.getMessage(),
                        clothingService.findAllClothingByType(clothingType)
                )
        );
    }

    //유저 소유 옷 타입별 전체보기
    @GetMapping("/my")
    public ResponseEntity<ResponseDto<List<UserClothingResDto>>> findAllMyClothingByType(@RequestParam(required = false) ClothingType clothingType) {
        return ResponseEntity.status(HttpStatus.OK).body(
                ResponseDto.create(ClothingResponseMessage.FIND_ALL_MY_CLOTHING.getMessage(),
                        userClothingService.findAllMyClothingByType(clothingType)
                )
        );
    }
}
