package com.richminime.domain.clothing.dao;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.domain.Clothing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClothingRepository extends JpaRepository<Clothing, Long> {
    List<Clothing> findAllByClothingType(ClothingType clothingType);
}
