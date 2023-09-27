package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dto.ClothingReqDto;
import com.richminime.domain.clothing.dto.ClothingResDto;
import com.richminime.domain.clothing.dto.ClothingUpdateReqDto;

import java.util.List;

public interface ClothingService {
    void addClothing(ClothingReqDto clothingReqDto);

    ClothingResDto updateClothing(ClothingUpdateReqDto clothingUpdateReqDto);

    List<ClothingResDto> findAllClothingByType(ClothingType clothingType);

    ClothingResDto findOneClothing(Long clothingId);

    void deleteClothing(Long clothingId);
}
