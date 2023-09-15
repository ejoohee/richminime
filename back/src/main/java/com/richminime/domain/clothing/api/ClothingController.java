package com.richminime.domain.clothing.api;


import com.richminime.domain.clothing.constant.ClothingResponseMessage;
import com.richminime.domain.clothing.dto.ClothingRequestDto.ClothingCreateRequestDto;
import com.richminime.domain.clothing.dto.ClothingRequestDto.ClothingUpdateRequestDto;
import com.richminime.domain.clothing.service.ClothingService;
import com.richminime.global.dto.ResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RequiredArgsConstructor
@RequestMapping("/clothing")
@RestController
public class ClothingController {
    private final ClothingService clothingService;

    //관리자
    @PostMapping("")
    public ResponseEntity<ResponseDto<?>> addClothing(@RequestBody @Valid ClothingCreateRequestDto clothingCreateRequestDto) {
        clothingService.addClothing(clothingCreateRequestDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(ResponseDto.create(
                ClothingResponseMessage.ADD_CLOTHING.getMessage()
        ));
    }

    @PutMapping("")
    public ResponseEntity<ResponseDto<?>> updateClothing(@RequestBody @Valid ClothingUpdateRequestDto clothingUpdateRequestDto) {
        clothingService.updateClothing(clothingUpdateRequestDto);

        return ResponseEntity.ok(ResponseDto.create(
                ClothingResponseMessage.UPDATE_CLOTHING.getMessage()
        ));
    }

    @DeleteMapping("/{clothingId}")
    public ResponseEntity<ResponseDto<?>> deleteClothing(@PathVariable("clothingId") Long clothingId) {
        clothingService.deleteClothing(clothingId);
        return ResponseEntity.status(HttpStatus.OK).body(ResponseDto.create(
                ClothingResponseMessage.DELETE_CLOTHING.getMessage()
        ));
    }
}
