package com.richminime.domain.item.entity;

import lombok.Getter;

@Getter
public enum ItemType {

    THEME_SET("테마세트"),
    FURNITURE_SET("가구세트"),
    WALLPAPER_SET("벽지세트");

    private String value;

    ItemType(String value) {
        this.value = value;
    }

    public static ItemType getItemType(String value) {
        if(value.contains("벽지"))
            return WALLPAPER_SET;
        else if(value.contains("가구"))
            return FURNITURE_SET;
        else
            return THEME_SET;
    }

}
