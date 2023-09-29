package com.richminime.domain.spending.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * 카테고리 별 합계 데이터
 */
@Getter
@Setter
@Builder
public class SpendingDto implements Serializable {

    String category;

    Long amount;

    public void addAmount(Long amount) {
        this.amount += amount;
    }

}
