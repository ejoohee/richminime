package com.richminime.domain.clothing.constant;

import com.richminime.global.exception.NotFoundException;

public enum ClothingType {
    상의("상의"),
    하의("하의"),
    드레스("드레스"),
    악세서리("악세서리"),
    신발("신발");

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

