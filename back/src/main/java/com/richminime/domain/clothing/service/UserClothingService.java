package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dto.AddUserClothingResDto;
import com.richminime.domain.clothing.dto.DeleteUserClothingResDto;
import com.richminime.domain.clothing.dto.UserClothingReqDto;
import com.richminime.domain.clothing.dto.UserClothingResDto;

import java.util.List;

public interface UserClothingService {
    AddUserClothingResDto addMyClothing(Long clothingId);
    DeleteUserClothingResDto deleteMyClothing(Long userClothingId);
    List<UserClothingResDto> findAllMyClothingByType(ClothingType clothingType);
}