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
public class SpendingDto implements Serializable, Comparable<SpendingDto> {

    String category;

    Long amount;

    public void addAmount(Long amount) {
        this.amount += amount;
    }

    @Override
    public int compareTo(SpendingDto o) {
        // amount를 기준으로 내림차순 정렬
        return Long.compare(o.amount, this.amount);
    }
}
