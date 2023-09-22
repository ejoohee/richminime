package com.richminime.domain.bankBook.api;

import com.richminime.domain.bankBook.constant.TransactionType;
import com.richminime.domain.bankBook.dto.BankBookResDto;
import com.richminime.domain.bankBook.service.BankBookService;
import com.richminime.global.dto.ResponseDto;
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
@RequestMapping("/bankbook")
@RestController
public class BankBookController {
    private final BankBookService bankBookService;

    //내역별전체보기
    @GetMapping("")
    public ResponseEntity<ResponseDto<List<BankBookResDto>>> findAllByUserIdByType(@RequestParam(required = false) TransactionType transactionType) {
        return ResponseEntity.status(HttpStatus.OK).body(
                ResponseDto.create(FIND_ALL_BANKBOOK.getMessage(),
                        bankBookService.findAllByUserIdAndType(transactionType))
        );
    }
}
