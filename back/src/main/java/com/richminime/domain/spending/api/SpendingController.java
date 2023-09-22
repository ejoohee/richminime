//package com.richminime.domain.spending.api;
//
//import com.richminime.domain.spending.service.SpendingService;
//import lombok.RequiredArgsConstructor;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//
//import java.util.Date;
//
//@RestController
//@RequiredArgsConstructor
//@RequestMapping("/spending")
//public class SpendingController {
//
//    private final SpendingService spendingService;
//
//    /**
//     * 월별 소비패턴 분석
//     * @param now
//     * @return
//     */
//    @GetMapping("/month")
//    public ResponseEntity<> analyzeMonthSpending(@RequestParam(name = "date") Date now) {
////        spendingService.analyzeMonthSpending();
//        return ResponseEntity.ok().body();
//    }
//
//    /**
//     * 일별 소비패턴 분석
//     * @param now
//     * @return
//     */
//    @GetMapping("/day")
//    public ResponseEntity<> analyzeDaySpending(@RequestParam(name = "date") Date now) {
//        return ResponseEntity.ok().body(userService.checkEmail(email));
//    }
//
//}
