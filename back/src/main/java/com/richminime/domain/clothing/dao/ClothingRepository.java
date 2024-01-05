package com.richminime.domain.clothing.dao;

import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.domain.Clothing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ClothingRepository extends JpaRepository<Clothing, Long> {
    List<Clothing> findAllByClothingTypeAndClothingIdNot(ClothingType clothingType, Long excludeClothingId);
    List<Clothing> findAllByClothingIdNot(Long clothingId);
    @Query("select c from Clothing c where c.clothingId = :clothingId")
    Optional<Clothing> findByclothingId (@Param("clothingId") Long clothingId);

}
