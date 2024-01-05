package com.richminime.domain.item.constant;

import lombok.Getter;

@Getter
public enum ItemType {

    벽지장판("벽지장판"),
    가구("가구"),
    러그("러그");

    private String value;

    ItemType(String value) {
        this.value = value;
    }

    public static ItemType getItemType(String value) {
        if(value.contains("벽지"))
            return 벽지장판;
        else if(value.contains("가구"))
            return 가구;
        else if(value.contains("러그"))
            return 러그;
        else
            return null; // 확장
    }

}
