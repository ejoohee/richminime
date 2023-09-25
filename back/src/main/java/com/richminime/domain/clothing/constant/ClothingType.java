package com.richminime.domain.clothing.constant;

import com.richminime.global.exception.NotFoundException;

public enum ClothingType {
    일상("일상"),
    파티("파티"),
    직업("직업");
    private final String value;

    ClothingType(String value) {this.value = value;}

    public String getValue() {
        return value;
    }

    public static ClothingType getClothingType(String value) {
        for (ClothingType type : values()) {
            if (type.value.equalsIgnoreCase(value)) {
                return type;
            }
        }
        throw new NotFoundException();
    }
}