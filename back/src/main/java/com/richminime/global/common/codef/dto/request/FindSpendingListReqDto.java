package com.richminime.global.common.codef.dto.request;

import com.richminime.domain.user.domain.User;
import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class FindSpendingListReqDto {

    private String organization;

    private String connectedId;

    private String birthDate;

    private String startDate;

    private String endDate;

    private String orderBy;

    private String inquiryType;

    private String cardName;

    private String duplicateCardIdx;

    private String cardNo;

    private String cardPassword;

    private String memberStoreInfoType;

    /**
     * 기본 생성 메서드
     * @param user
     * @param startDate
     * @param endDate
     * @return
     */
    public static FindSpendingListReqDto create(User user, String startDate, String endDate) {
        return FindSpendingListReqDto.builder()
                .organization(user.getOrganizationCode())
                .connectedId(user.getConnectedId())
                .birthDate("")
                .startDate(startDate)
                .endDate(endDate)
                // 과거순 정렬
                .orderBy("1")
                // 카드별 조회
                .inquiryType("0")
                .cardName("")
                .duplicateCardIdx("0")
                .cardNo(user.getCardNumber())
                .cardPassword("")
                .memberStoreInfoType("1")
                .build();
    }


}
