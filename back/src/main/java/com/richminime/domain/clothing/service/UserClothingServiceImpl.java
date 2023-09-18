package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dao.ClothingRepository;
import com.richminime.domain.clothing.dao.UserClothingRepository;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.clothing.domain.UserClothing;
import com.richminime.domain.clothing.dto.ClothingRequestDto.UserClothingCreateRequestDto;
import com.richminime.domain.clothing.dto.ClothingRequestDto.UserClothingUpdateRequestDto;
import com.richminime.domain.clothing.dto.ClothingResponseDto.UserClothingInfoResponseDto;
import com.richminime.domain.clothing.exception.ClothingNotFoundException;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.exception.UserNotFoundException;
import com.richminime.domain.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static com.richminime.domain.clothing.constant.ClothingExceptionMessage.CLOTHING_NOT_FOUND;
import static com.richminime.domain.user.exception.UserExceptionMessage.USER_NOT_FOUND;

@Service
@RequiredArgsConstructor
public class UserClothingServiceImpl implements UserClothingService {

    private final UserClothingRepository userClothingRepository;
    private final ClothingRepository clothingRepository;
    private final UserRepository userRepository;

    @Transactional
    @Override
    public void addMyClothing(UserClothingCreateRequestDto userClothingCreateRequestDto) {

        long userId = userClothingCreateRequestDto.getUserId();
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new UserNotFoundException(USER_NOT_FOUND.getMessage()));

        long clothingId = userClothingCreateRequestDto.getClothingId();
        Clothing clothing = clothingRepository.findById(clothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        UserClothing userClothing = UserClothing.builder()
                .clothing(clothing)
                .user(user)
                .build();

        userClothingRepository.save(userClothing);
    }

    @Transactional
    @Override
    public void updateMyClothing(UserClothingUpdateRequestDto userClothingUpdateRequestDto) {
    }

    @Transactional
    @Override
    public void deleteMyClothing(Long userClothingId) {
        UserClothing userClothing = userClothingRepository.findById(userClothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        User user = userClothing.getUser();
        long newBalance = user.getBalance() + Math.round(userClothing.getClothing().getPrice() * 0.4);
        user.updateBalance(newBalance);

        //TODO bank에도 판매 log 기록

        userClothingRepository.delete(userClothing);
    }

    @Transactional
    @Override
    public List<UserClothingInfoResponseDto> findAllMyClothingByType(ClothingType clothingType) {
        if (clothingType == null) {
            List<UserClothing> userClothingList = userClothingRepository.findAll();
            List<UserClothingInfoResponseDto> userClothingInfoResponseDtoList = new ArrayList<>();
            for (UserClothing userClothing : userClothingList) {
                UserClothingInfoResponseDto dto = UserClothingInfoResponseDto.builder()
                        .userclothing(userClothing)
                        .build();
                userClothingInfoResponseDtoList.add(dto);
            }
            return userClothingInfoResponseDtoList;
        } else {
            List<UserClothing> userClothingListByType = userClothingRepository.findAllByClothingType(clothingType);
            List<UserClothingInfoResponseDto> userClothingInfoResponseDtoListByType = new ArrayList<>();
            for (UserClothing userClothing : userClothingListByType) {
                UserClothingInfoResponseDto dto = UserClothingInfoResponseDto.builder()
                        .userclothing(userClothing)
                        .build();
                userClothingInfoResponseDtoListByType.add(dto);
            }
            return userClothingInfoResponseDtoListByType;
        }
    }
}