package com.richminime.domain.item.repository;

import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.domain.ItemType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Repository
public interface ItemRepository extends JpaRepository<Item, Long> {

    Optional<Item> findItemByItemId(Long itemId);
    List<Item> findAllByItemAndItemType(ItemType itemType);


}
