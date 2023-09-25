package com.richminime.domain.bankBook.dao;

import com.richminime.domain.bankBook.constant.TransactionType;
import com.richminime.domain.bankBook.domain.BankBook;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BankBookRepository extends JpaRepository<BankBook, Long> {
    List<BankBook> findAllByUserId(Long userId);

    List<BankBook> findAllByUserIdAndTransactionType(Long userId, TransactionType transactionType);

}
