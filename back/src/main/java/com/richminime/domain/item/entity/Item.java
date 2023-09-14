package com.richminime.domain.item.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Item {
    // itemId, itemName, itemType, itemImg, itemInfo, price

    @Id @GeneratedValue
    private Long itemId;

    @Column(name = "item_name", length = 50, nullable = false)
    private String itemName;

    @Column(name = "item_type", columnDefinition = "varchar(50)", nullable = false)
    @Enumerated(value = EnumType.STRING)
    private ItemType itemType;

    @Column(name = "item_img", length = 250, nullable = false)
    private String itemImg;

    @Column(name = "item_info", length = 250)
    private String itemInfo;

    @Column(name = "price", columnDefinition = "BIGINT DEFAULT 0")
    private Long price;

    @OneToMany(mappedBy = "item", fetch = FetchType.LAZY)
    private List<UserItem> userItems;

}
