package com.richminime.domain.spending.domain;

import lombok.Builder;
import lombok.Getter;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;
import org.springframework.data.redis.core.TimeToLive;

import java.util.List;
import java.util.Map;

@Getter
@RedisHash("daySpendingPattern")
@Builder
public class DaySpendingPattern {

    @Id
    private String email;

    /**
     * 월 정보
     */
    private Integer month;

    /**
     * 일 정보
     */
    private Integer day;

    /**
     * 각 type 별 소비한 양을 저장
     * ex) 제과점 - 10000원, 편의점 - 5000원
     */
    private Map<String, Long> spendingAmountMap;

    // 일 전체 소비 금액 합계
    private Long totalAmount;

    // 피드백 타입
    // 어제 vs 그저께 전체 소비량 비교한 결과
    // 더 적게 썼으면 true 많이 썼으면 false
    // null인 경우 전날에 소비한 금액과 동일한 경우?
    private Boolean lessSpent;

    // 가장 많이쓴 유형(최댓값이 같으면 여러개가 되므로 리스트 형태)
    private List<String> maxSpentCategoryList;

    // 가장 많이쓴 유형의 소비량
    private Long maxAmount;

    @TimeToLive
    private Long expiration;

}
