package com.richminime.domain.item.repository;

import com.richminime.domain.item.domain.ItemType;
import com.richminime.domain.item.domain.UserItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserItemRepository extends JpaRepository<UserItem, Long> {

    // 유저별 기능
    // 소유한 테마 전체 조회
    // 소유한 테마 상세 조회
    // 소유한 테마 카테고리별 조회
    // 소유한 테마 적용하기, 벗기기
    // 소유하지 않은 테마 구매하기
    // 소유한 테마 판매하기

    // 아이템 번호와 유저 번호로 유저아이템 찾기
//    @Query(value = "select * from user_item where item_id = :itemId and user_id = :userId", nativeQuery = true)
    UserItem findUserItemByItemAndUser(Long itemId, Long userId);

    @Query(value = "select * from user_item where user_id = :userId", nativeQuery = true)
    List<UserItem> findAllByUserId(Long userId);

    @Query(value = "select * from user_item where user_id = :userId and item_type = :itemType", nativeQuery = true)
    List<UserItem> findAllByUserIdAndItemType(Long userId, ItemType itemType);
}
