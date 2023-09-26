package com.richminime.domain.spending.repository;

import com.richminime.domain.spending.domain.Spending;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Date;
import java.util.List;

public interface SpendingRepository extends JpaRepository<Spending, Long> {

    /**
     * 해당 회원의 startDate와 endDate 사이에 해당하는 소비내역 가져옴
     */
    List<Spending> findSpendingByUserIdAndSpentDateBetween(Long userId, Date startDate, Date endDate);


}
