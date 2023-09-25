package com.richminime.domain.bankBook.service;

import com.richminime.domain.bankBook.constant.TransactionType;
import com.richminime.domain.bankBook.dto.BankBookResDto;

import java.util.List;

public interface BankBookService {
    List<BankBookResDto> findAllByUserIdAndType(TransactionType transactionType);
}
