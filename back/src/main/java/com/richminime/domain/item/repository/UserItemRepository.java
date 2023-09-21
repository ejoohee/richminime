package com.richminime.domain.item.repository;

import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.domain.ItemType;
import com.richminime.domain.item.domain.UserItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserItemRepository extends JpaRepository<Item, Long> {

    // 유저별 기능
    // 소유한 테마 전체 조회
    // 소유한 테마 상세 조회
    // 소유한 테마 카테고리별 조회
    // 소유한 테마 적용하기, 벗기기
    // 소유하지 않은 테마 구매하기
    // 소유한 테마 판매하기

    @Query(value = "select * from user_item where user_id = :userId", nativeQuery = true)
    List<UserItem> findAllByUserId(Long userId);

//    List<Item> findAllByItemType(ItemType itemType, String token);
}
