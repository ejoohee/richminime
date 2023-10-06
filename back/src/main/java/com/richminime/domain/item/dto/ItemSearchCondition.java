package com.richminime.domain.item.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ItemSearchCondition {

    String option; // random & selled 인기순
    String name; // 포함
    Long price; // 이상/이하
    Boolean owned; // 기소유


}
