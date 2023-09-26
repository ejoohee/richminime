package com.richminime.domain.character.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.richminime.domain.character.domain.Character;
public interface CharacterRepository extends JpaRepository<Character,Long> {

}
