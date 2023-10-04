package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dao.ClothingRepository;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.clothing.dto.ClothingReqDto;
import com.richminime.domain.clothing.dto.ClothingResDto;
import com.richminime.domain.clothing.dto.ClothingUpdateReqDto;
import com.richminime.domain.clothing.exception.ClothingNotFoundException;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.domain.UserType;
import com.richminime.domain.user.exception.UserNotFoundException;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.exception.ForbiddenException;
import com.richminime.global.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static com.richminime.domain.clothing.constant.ClothingExceptionMessage.CLOTHING_NOT_FOUND;
import static com.richminime.domain.user.exception.UserExceptionMessage.USER_NOT_FOUND;

@Service
@RequiredArgsConstructor
public class ClothingServiceImpl implements ClothingService {

    private final ClothingRepository clothingRepository;
    private final UserRepository userRepository;
    private final SecurityUtils securityUtils;

    private User getLoggedInUser() {
        String loggedInUserEmail = securityUtils.getLoggedInUserEmail();
        return userRepository.findByEmail(loggedInUserEmail)
                .orElseThrow(() -> new UserNotFoundException(USER_NOT_FOUND.getMessage()));
    }

    private void checkAdminAuthority(User user) {
        if (!user.getUserType().equals(UserType.ROLE_ADMIN)) {
            throw new ForbiddenException();
        }
    }

    @Transactional
    @Override
    public ClothingResDto addClothing(ClothingReqDto clothingReqDto) {
        User user = getLoggedInUser();
        checkAdminAuthority(user);

        Clothing clothing = Clothing.builder()
                .clothingName(clothingReqDto.getClothingName())
                .clothingType(ClothingType.getClothingType(clothingReqDto.getClothingType()))
                .clothingImg(clothingReqDto.getClothingImg())
                .clothingApplyImg(clothingReqDto.getClothingApplyImg())
                .clothingInfo(clothingReqDto.getClothingInfo())
                .price(clothingReqDto.getPrice())
                .build();

        clothingRepository.save(clothing);
        return ClothingResDto.entityToDto(clothing);
    }

    @Transactional
    @Override
    public ClothingResDto updateClothing(ClothingUpdateReqDto clothingUpdateReqDto) {
        User user = getLoggedInUser();
        checkAdminAuthority(user);

        Clothing clothing = clothingRepository.findById(clothingUpdateReqDto.getClothingId())
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        clothing.update(clothingUpdateReqDto.getClothingName(), clothingUpdateReqDto.getClothingType(),
                clothingUpdateReqDto.getClothingImg(), clothingUpdateReqDto.getClothingApplyImg(),
                clothingUpdateReqDto.getClothingInfo(), clothingUpdateReqDto.getPrice());

        return ClothingResDto.entityToDto(clothing);
    }

    @Transactional
    @Override
    public List<ClothingResDto> findAllClothingByType(ClothingType clothingType) {
        if (clothingType == null) {
            List<Clothing> clothingList = clothingRepository.findAll();
            List<ClothingResDto> clothingInfoResponseDtoList = new ArrayList<>();
            for (Clothing clothing : clothingList) {
                ClothingResDto dto = ClothingResDto.entityToDto(clothing);
                clothingInfoResponseDtoList.add(dto);
            }
            return clothingInfoResponseDtoList;
        } else {
            List<Clothing> clothingListByType = clothingRepository.findAllByClothingType(clothingType);
            List<ClothingResDto> clothingInfoResponseDtoListByType = new ArrayList<>();
            for (Clothing clothing : clothingListByType) {
                ClothingResDto dto = ClothingResDto.entityToDto(clothing);
                clothingInfoResponseDtoListByType.add(dto);
            }
            return clothingInfoResponseDtoListByType;
        }
    }

    @Transactional
    @Override
    public ClothingResDto findOneClothing(Long clothingId) {
        Clothing clothing = clothingRepository.findById(clothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));
        return ClothingResDto.entityToDto(clothing);
    }

    @Transactional
    @Override
    public void deleteClothing(Long clothingId) {
        User user = getLoggedInUser();
        checkAdminAuthority(user);

        Clothing clothing = clothingRepository.findById(clothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        clothingRepository.delete(clothing);
    }
}