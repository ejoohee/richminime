package com.richminime.domain.spending.api;

import com.richminime.domain.spending.dto.response.FindDaySpendingResDto;
import com.richminime.domain.spending.dto.response.FindMonthSpendingResDto;
import com.richminime.domain.spending.service.SpendingService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/spending")
public class SpendingController {

    private final SpendingService spendingService;

    /**
     * 월별 소비패턴 분석
     * @return
     */
    @GetMapping("/month")
    public ResponseEntity<FindMonthSpendingResDto> analyzeMonthSpending() {
        return ResponseEntity.ok().body(spendingService.findMonthSpending());
    }

    /**
     * 일별 소비패턴 분석
     * @return
     */
    @GetMapping("/day")
    public ResponseEntity<FindDaySpendingResDto> analyzeDaySpending() {
        return ResponseEntity.ok().body(spendingService.findDaySpending());
    }

}
