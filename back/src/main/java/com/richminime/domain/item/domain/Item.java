package com.richminime.domain.item.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

@Entity
@Getter
@SuperBuilder
@DynamicInsert
@NoArgsConstructor
@AllArgsConstructor
public class Item {

    // itemId, itemName, itemType, itemImg, itemInfo, price\
    @Id @GeneratedValue
    @Column(name = "item_id")
    private Long itemId;

    @Column(name = "item_name", length = 50, nullable = false)
    private String itemName;

    @Column(name = "item_type", columnDefinition = "varchar(50)", nullable = false)
    @Enumerated(EnumType.STRING)
    private ItemType itemType;

    @Column(name = "item_img", length = 255, nullable = false)
    private String itemImg;

    @Column(name = "item_info", length = 255, nullable = true)
    private String itemInfo;

    @Column(name = "price", nullable = false)
    private Long price;





}
