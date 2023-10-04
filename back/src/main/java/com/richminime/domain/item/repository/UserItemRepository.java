package com.richminime.domain.item.repository;

import com.richminime.domain.item.constant.ItemType;
import com.richminime.domain.item.domain.UserItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserItemRepository extends JpaRepository<UserItem, Long> {

    // 아이템 번호와 유저 번호로 유저아이템 찾기
//    @Query(value = "select * from user_item where item_id = :itemId and user_id = :userId", nativeQuery = true)
//    UserItem findUserItemByItemAndUser(Long itemId, Long userId);
    boolean existsByUser_UserIdAndItem_ItemId(Long userId, Long itemId);

//    @Query(value = "select * from user_item where user_id = :userId", nativeQuery = true)
//    List<UserItem> findAllByUserId(Long userId);
    List<UserItem> findAllByUser_UserId(Long userId);

//    @Query(value = "select * from user_item where user_id = :userId and item_type = :itemType", nativeQuery = true)
//    List<UserItem> findAllByUserIdAndItemType(Long userId, ItemType itemType);
    List<UserItem> findAllByUser_UserIdAndItem_ItemType(Long userId, ItemType itemType);
}
