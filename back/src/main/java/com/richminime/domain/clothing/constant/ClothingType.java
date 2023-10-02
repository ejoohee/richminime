package com.richminime.domain.clothing.constant;

import com.richminime.global.exception.NotFoundException;

public enum ClothingType {
    일상("일상"),
    직업("직업"),
    동물잠옷("동물잠옷"),
    코스프레("코스프레");
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