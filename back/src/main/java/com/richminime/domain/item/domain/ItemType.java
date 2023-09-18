package com.richminime.domain.item.domain;

import lombok.Getter;

@Getter
public enum ItemType {

    ITEM_THEME_SET("테마"), // 가구 + 벽지 + 바닥 세트
    ITEM_FURNITURE_SET("가구세트"), // 가구만 세트
    ITEM_WALLPAPER_SET("벽지세트"), // 벽지 + 바닥 세트
    
    // 아래 3개는 나중에 확장할 예정
    ITEM_FURNITURE("가구"),
    ITEM_WALLPAPER("벽지"),
    ITEM_MAT("장판");

    private String value;

    ItemType(String value) {
        this.value = value;
    }

    public static ItemType getItemType(String value) {
        if(value.contains("테마"))
            return ITEM_THEME_SET;

        else if(value.contains("가구세트"))
            return ITEM_FURNITURE_SET;

        else if(value.contains("벽지세트"))
            return ITEM_WALLPAPER_SET;
        
        else if(value.contains("가구"))
            return ITEM_FURNITURE;
        
        else if(value.contains("벽지"))
            return ITEM_WALLPAPER;
        
        else if(value.contains("장판"))
            return ITEM_MAT;
        
        else 
            return null; // 나중에 확장
    }

}
