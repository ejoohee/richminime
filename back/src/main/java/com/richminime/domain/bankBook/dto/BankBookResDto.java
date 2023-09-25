package com.richminime.domain.bankBook.dto;

import com.richminime.domain.bankBook.constant.TransactionType;
import com.richminime.domain.bankBook.domain.BankBook;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDate;

@Data
@Builder
public class BankBookResDto {

    private final Long bankBookId;
    private final long amount;
    private final LocalDate date;
    private final long balance;
    private final String transactionType;
    private final String summary;

    public static BankBookResDto entityToDto(BankBook bankBook) {
        return BankBookResDto.builder()
                .bankBookId(bankBook.getBankBookId())
                .amount(bankBook.getAmount())
                .date(bankBook.getDate())
                .balance(bankBook.getBalance())
                .transactionType(bankBook.getTransactionType().getValue())
                .summary(bankBook.getSummary())
                .build();
    }
}
