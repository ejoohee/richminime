package com.richminime.domain.spending.domain;

import com.richminime.domain.user.domain.User;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.util.Date;

@Getter
@DynamicInsert
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
public class Spending {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "spending_id")
    private Long spendingId;

    private Long userId;

    private String category;

    private Date spentDate;

    private Long cost;

    private Integer storeNo;

    @Builder
    public Spending(Long userId, String category, Date spentDate, Long cost, Integer storeNo) {
        this.userId = userId;
        this.category = category;
        this.spentDate = spentDate;
        this.cost = cost;
        this.storeNo = storeNo;
    }

}
