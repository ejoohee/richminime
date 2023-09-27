package com.richminime.domain.spending.domain;

import lombok.Builder;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

import java.util.HashMap;
import java.util.Map;

@Getter
@RedisHash("monthSpendingPattern")
public class MonthSpendingPattern {

    @Id
    private String email;

    /**
     * 월 정보
     */
    private Integer month;

    /**
     * 각 type 별 소비한 양을 저장
     * ex) 제과점 - 10000원, 편의점 - 5000원
     */
    private Map<String, Long> spendingAmountMap;

    // 전체 소비 금액 합계
    private Long totalAmount;

    @TimeToLive
    private Long expiration;

    @Builder
    public MonthSpendingPattern(String email, Integer month, Long expiration, Map<String, Long> spendingAmountMap, Long totalAmount) {
        this.email = email;
        this.month = month;
        this.expiration = expiration;
        this.spendingAmountMap = spendingAmountMap;
        this.totalAmount = totalAmount;
    }

}
