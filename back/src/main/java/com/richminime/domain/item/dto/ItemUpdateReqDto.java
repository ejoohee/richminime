package com.richminime.domain.item.dto;

import lombok.Data;

@Data
public class ItemUpdateReqDto {
    
    String itemName;
    String itemImg; 
    String itemInfo;
    Long price;
    
    // 타입이나 id는 변경 불가


}
