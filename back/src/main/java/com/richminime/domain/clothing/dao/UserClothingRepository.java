package com.richminime.domain.clothing.dao;

import com.richminime.domain.clothing.domain.UserClothing;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserClothingRepository extends JpaRepository <UserClothing, Long> {
}
