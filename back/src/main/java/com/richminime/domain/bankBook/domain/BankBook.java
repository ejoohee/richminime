package com.richminime.domain.bankBook.domain;

import com.richminime.domain.bankBook.constant.TransactionType;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import java.time.LocalDate;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class BankBook {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bankBookId;

    private Long userId;

    private long amount;

    private LocalDate date;

    private long balance;

    private TransactionType transactionType;

    private String summary;


    @Builder
    public BankBook(Long bankBookId, Long userId, long amount, LocalDate date,
                    long balance, TransactionType transactionType, String summary) {
        this.bankBookId = bankBookId;
        this.userId = userId;
        this.amount = amount;
        this.date = date;
        this.balance = balance;
        this.transactionType = transactionType;
        this.summary = summary;
    }
}
