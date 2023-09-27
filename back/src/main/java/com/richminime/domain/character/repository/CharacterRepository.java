package com.richminime.domain.character.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.richminime.domain.character.domain.Character;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface CharacterRepository extends JpaRepository<Character,Long> {

    @Query("select c from Character c where c.user.userId = :userid")
    Optional<Character> findByUserId(@Param("userid") Long userId);


}
