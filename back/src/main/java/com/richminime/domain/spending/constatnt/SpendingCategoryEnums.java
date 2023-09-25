package com.richminime.domain.spending.constatnt;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SpendingCategoryEnums {

    INTERNET_PG("전자상거래PG", "기타");

    private String category;
    private String value;

}
