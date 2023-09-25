package com.richminime.domain.clothing.service;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dao.ClothingRepository;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.clothing.dto.ClothingReqDto;
import com.richminime.domain.clothing.dto.ClothingResDto;
import com.richminime.domain.clothing.dto.ClothingUpdateReqDto;
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
    public void addClothing(ClothingReqDto clothingReqDto) {
        //TODO 관리자 확인 필요
        Clothing clothing = Clothing.builder()
                .clothingName(clothingReqDto.getClothingName())
                .clothingType(ClothingType.getClothingType(clothingReqDto.getClothingType()))
                .clothingImg(clothingReqDto.getClothingImg())
                .clothingInfo(clothingReqDto.getClothingInfo())
                .price(clothingReqDto.getPrice())
                .build();

        clothingRepository.save(clothing);
    }

    @Transactional
    @Override
    public void updateClothing(ClothingUpdateReqDto clothingUpdateReqDto) {
        Clothing clothing = clothingRepository.findById(clothingUpdateReqDto.getClothingId())
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        clothing.update(clothingUpdateReqDto.getClothingName(), clothingUpdateReqDto.getClothingType(),
                clothingUpdateReqDto.getClothingImg(), clothingUpdateReqDto.getClothingInfo(),
                clothingUpdateReqDto.getPrice());
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
        Clothing clothing = clothingRepository.findById(clothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        clothingRepository.delete(clothing);
    }
}