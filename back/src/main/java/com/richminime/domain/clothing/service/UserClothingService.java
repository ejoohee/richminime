package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dto.ClothingResDto;
import com.richminime.domain.clothing.dto.UserClothingReqDto;
import com.richminime.domain.clothing.dto.UserClothingResDto;

import java.util.List;

public interface UserClothingService {
    void addMyClothing(UserClothingReqDto userClothingReqDto);
    //TODO 내가 입고 있는 옷 정보 Character 갱신 -> 갈아입기 (Character도메인 ?)
    //void updateMyClothing(UserClothingUpdateReqDto userClothingUpdateRequestDto);
    void deleteMyClothing(Long userClothingId);
    List<UserClothingResDto> findAllMyClothingByType(ClothingType clothingType);
}