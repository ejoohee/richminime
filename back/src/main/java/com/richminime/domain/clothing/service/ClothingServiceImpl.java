package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dao.ClothingRepository;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.clothing.dto.ClothingRequestDto.ClothingCreateRequestDto;
import com.richminime.domain.clothing.dto.ClothingRequestDto.ClothingUpdateRequestDto;
import com.richminime.domain.clothing.dto.ClothingResponseDto.ClothingInfoResponseDto;
import com.richminime.domain.clothing.exception.ClothingNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

import static com.richminime.domain.clothing.constant.ClothingExceptionMessage.CLOTHING_NOT_FOUND;

@Service
@RequiredArgsConstructor
public class ClothingServiceImpl implements ClothingService {

    private final ClothingRepository clothingRepository;

    @Transactional
    @Override
    public void addClothing(ClothingCreateRequestDto clothingCreateRequestDto) {
        //관리자 확인 필요
        Clothing clothing = Clothing.builder()
                .clothingName(clothingCreateRequestDto.getClothingName())
                .clothingType(clothingCreateRequestDto.getClothingType())
                .clothingImg(clothingCreateRequestDto.getClothingImg())
                .clothingInfo(clothingCreateRequestDto.getClothingInfo())
                .price(clothingCreateRequestDto.getPrice())
                .build();

        clothingRepository.save(clothing);
    }

    @Transactional
    @Override
    public void updateClothing(ClothingUpdateRequestDto clothingUpdateRequestDto) {
        Clothing clothing = clothingRepository.findById(clothingUpdateRequestDto.getClothingId())
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        clothing.update(clothingUpdateRequestDto.getClothingName(), clothingUpdateRequestDto.getClothingType(),
                clothingUpdateRequestDto.getClothingImg(), clothingUpdateRequestDto.getClothingInfo(),
                clothingUpdateRequestDto.getPrice());
    }

    @Transactional
    @Override
    public List<ClothingInfoResponseDto> findAllClothingByType(ClothingType clothingType) {
        List<Clothing> clothingList = clothingRepository.findAllByClothingType(clothingType);

        List<ClothingInfoResponseDto> clothingInfoResponseDtoList = new ArrayList<>();
        for (Clothing clothing : clothingList) {
            ClothingInfoResponseDto dto = ClothingInfoResponseDto.builder()
                    .clothing(clothing)
                    .build();
            clothingInfoResponseDtoList.add(dto);
        }
        return clothingInfoResponseDtoList;
    }

    @Transactional
    @Override
    public ClothingInfoResponseDto findOneClothing(Long clothingId) {
        Clothing clothing = clothingRepository.findById(clothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));
        return ClothingInfoResponseDto.builder()
                .clothing(clothing)
                .build();
    }

    @Transactional
    @Override
    public void deleteClothing(Long clothingId) {
        Clothing clothing = clothingRepository.findById(clothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        clothingRepository.delete(clothing);
    }
}