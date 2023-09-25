package com.richminime.domain.spending.dto.response;


import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class FindMonthSpendingResDto {

    // 몇월 데이터인지
    private Integer month;
    // 소비내역 업종별로 소비한 금액 합계 정보 저장
    private List<SpendingDto> spendingAmountList;
    // 전체 소비 금액 합계
    private Long totalAmount;

}
