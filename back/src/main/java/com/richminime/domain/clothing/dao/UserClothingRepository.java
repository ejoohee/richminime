package com.richminime.domain.clothing.dao;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.domain.UserClothing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserClothingRepository extends JpaRepository<UserClothing, Long> {
    List<UserClothing> findAllByClothing_ClothingType(ClothingType clothingType);
}
