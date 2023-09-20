package com.richminime.domain.item.domain;

import com.richminime.domain.item.dto.ItemUpdateReqDto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.util.List;

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
    
    @OneToMany(mappedBy = "item")
    private List<UserItem> userItems; // 하나의 아이템(청치마)를 산 유저가 많으니까

    public void updateItem(ItemUpdateReqDto itemUpdateReqDto) {
        this.itemName = itemUpdateReqDto.getItemName() == null ? this.itemName : itemUpdateReqDto.getItemName();
        this.itemImg = itemUpdateReqDto.getItemImg() == null ? this.itemImg : itemUpdateReqDto.getItemImg();
        this.itemInfo = itemUpdateReqDto.getItemInfo() == null ? this.itemInfo : itemUpdateReqDto.getItemInfo();
        this.price = itemUpdateReqDto.getPrice() == null ? price : itemUpdateReqDto.getPrice();
    }



}
