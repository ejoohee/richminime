package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dto.ClothingRequestDto.ClothingCreateRequestDto;
import com.richminime.domain.clothing.dto.ClothingRequestDto.ClothingUpdateRequestDto;
import com.richminime.domain.clothing.dto.ClothingResponseDto.ClothingInfoResponseDto;

import java.util.List;

public interface ClothingService {
    void addClothing(ClothingCreateRequestDto clothingCreateRequestDto);
    void updateClothing(ClothingUpdateRequestDto clothingUpdateRequestDto);
    List<ClothingInfoResponseDto> findAllClothingByType(ClothingType clothingType);
    ClothingInfoResponseDto findOneClothing(Long clothingId);
    void deleteClothing(Long clothingId);
}
