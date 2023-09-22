package com.richminime.domain.bankBook.service;

import com.richminime.domain.bankBook.constant.TransactionType;
import com.richminime.domain.bankBook.dao.BankBookRepository;
import com.richminime.domain.bankBook.domain.BankBook;
import com.richminime.domain.bankBook.dto.BankBookResDto;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BankBookServiceImpl implements BankBookService {

    private final BankBookRepository bankBookRepository;
    private final UserRepository userRepository;

    @Transactional
    @Override
    public List<BankBookResDto> findAllByUserIdAndType(TransactionType transactionType) {
        String loggedInUserEmail = SecurityUtils.getLoggedInUserEmail();
        Long userId = userRepository.findByEmail(loggedInUserEmail).get().getUserId();

        if (transactionType == null) {
            List<BankBook> bankBookList = bankBookRepository.findAllByUserId(userId);
            List<BankBookResDto> bankBookResDtoList = new ArrayList<>();
            for (BankBook bankBook : bankBookList) {
                BankBookResDto dto = BankBookResDto.entityToDto(bankBook);
                bankBookResDtoList.add(dto);
            }
            return bankBookResDtoList;
        } else {
            List<BankBook> bankBookListByType = bankBookRepository.findAllByUserIdAndTransactionType(userId, transactionType);
            List<BankBookResDto> bankBookResDtoListByType = new ArrayList<>();
            for (BankBook bankBook : bankBookListByType) {
                BankBookResDto dto = BankBookResDto.entityToDto(bankBook);
                bankBookResDtoListByType.add(dto);
            }
            return bankBookResDtoListByType;
        }
    }
}
