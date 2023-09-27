package com.richminime.domain.item.repository;

import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.domain.ItemType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;


import java.util.List;
import java.util.Optional;

@Repository
public interface ItemRepository extends JpaRepository<Item, Long> {

    Optional<Item> findItemByItemId(Long itemId);
    List<Item> findAllByItemType(ItemType itemType);

    @Query("select i from Item i where i.itemId = :itemid")
    Optional<Item> findByItemId (@Param("itemid") Long itemid);

}
