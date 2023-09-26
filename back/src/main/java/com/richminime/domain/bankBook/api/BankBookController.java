package com.richminime.domain.bankBook.api;

import com.richminime.domain.bankBook.constant.TransactionType;
import com.richminime.domain.bankBook.dto.BankBookResDto;
import com.richminime.domain.bankBook.service.BankBookService;
import com.richminime.global.dto.ResponseDto;
import io.swagger.v3.oas.annotations.Operation;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

import static com.richminime.domain.bankBook.constant.BankBookResponseMessage.FIND_ALL_BANKBOOK;

@RequiredArgsConstructor
@RequestMapping("/api/bankbook")
@RestController
public class BankBookController {
    private final BankBookService bankBookService;

    //내역별전체보기
    @Operation(
            summary = "로그인 사용자의 통장내역 전체 또는 카테고리별 조회 ",
            description = "선택한 방법으로 통장내역을 조회합니다."
    )
    @GetMapping("")
    public ResponseEntity<ResponseDto<List<BankBookResDto>>> findAllByUserIdByType(@RequestParam(required = false) TransactionType transactionType) {
        return ResponseEntity.status(HttpStatus.OK).body(
                ResponseDto.create(FIND_ALL_BANKBOOK.getMessage(),
                        bankBookService.findAllByUserIdAndType(transactionType))
        );
    }*/
    @GetMapping("")
    public ResponseEntity<String> get(){
        return ResponseEntity.ok("ok");
    }
}
