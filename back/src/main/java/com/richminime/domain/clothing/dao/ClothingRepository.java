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
    List<Clothing> findAllByClothingType(ClothingType clothingType);

    @Query("select c from Clothing c where c.clothingId = :clothingid")
    Optional<Clothing> findByUserId (@Param("clothingid") Long userId);


}
