package com.richminime.domain.spending.repository;

import com.richminime.domain.spending.domain.Spending;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SpendingRepository extends JpaRepository<Spending, Long> {



}
