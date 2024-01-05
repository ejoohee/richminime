package com.richminime.domain.spending.repository;

import com.richminime.domain.spending.domain.DaySpendingPattern;
import com.richminime.domain.spending.domain.MonthSpendingPattern;
import org.springframework.data.repository.CrudRepository;

public interface DaySpendingPatternRedisRepository extends CrudRepository<DaySpendingPattern, String> {


}
