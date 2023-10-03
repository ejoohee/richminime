package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dto.ClothingResDto;
import com.richminime.domain.clothing.dto.UserClothingReqDto;
import com.richminime.domain.clothing.dto.UserClothingResDto;

import java.util.List;

public interface UserClothingService {
//    void addMyClothing(UserClothingReqDto userClothingReqDto);
    void addMyClothing(Long clothingId);
    void deleteMyClothing(Long userClothingId);
    List<UserClothingResDto> findAllMyClothingByType(ClothingType clothingType);
}