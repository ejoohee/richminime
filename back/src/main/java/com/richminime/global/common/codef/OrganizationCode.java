package com.richminime.global.common.codef;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OrganizationCode {

    KB_CARD("0301"),
    HYNDAI_CARD("0302"),
    SAMSUNG_CARD("0303"),
    NH_CARD("0304"),
    BC_CARD("0305"),
    SINHAN_CARD("0306"),
    CITY_CARD("0307"),
    DEV_BANK_CARD("0002"),
    WOORI_CARD("0309"),
    LOTTE_CARD("0311"),
    HANA_CARD("0313"),
    JEONBOOK_CARD("0315"),
    KWANGJU_CARD("0316"),
    SUHYUP_CARD("0320"),
    JEJU_CARD("0321");

    String code;

}
