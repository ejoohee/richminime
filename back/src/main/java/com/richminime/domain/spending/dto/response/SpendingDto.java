package com.richminime.domain.spending.dto.response;

import lombok.Builder;
import lombok.Getter;

/**
 * 카테고리 별 합계 데이터
 */
@Getter
@Builder
public class SpendingDto {

    String category;

    Long amount;

}
