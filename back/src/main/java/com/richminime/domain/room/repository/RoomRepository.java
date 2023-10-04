package com.richminime.domain.room.repository;

import com.richminime.domain.room.domain.Room;
import org.springframework.data.jpa.repository.JpaRepository;
import com.richminime.domain.character.domain.Character;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface RoomRepository extends JpaRepository<Room,Long> {

    @Query("select r from Room r where r.user.userId = :userId")
    Optional<List<Room>> findByUserId(@Param("userId") Long userId);


}
