package com.richminime.domain.clothing.service;

import com.richminime.domain.bankBook.constant.TransactionType;
import com.richminime.domain.bankBook.dao.BankBookRepository;
import com.richminime.domain.bankBook.domain.BankBook;
import com.richminime.domain.clothing.constant.ClothingType;
import com.richminime.domain.clothing.dao.ClothingRepository;
import com.richminime.domain.clothing.dao.UserClothingRepository;
import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.clothing.domain.UserClothing;
import com.richminime.domain.clothing.dto.AddUserClothingResDto;
import com.richminime.domain.clothing.dto.DeleteUserClothingResDto;
import com.richminime.domain.clothing.dto.UserClothingResDto;
import com.richminime.domain.clothing.exception.ClothingDuplicatedException;
import com.richminime.domain.clothing.exception.ClothingInsufficientBalanceException;
import com.richminime.domain.clothing.exception.ClothingNotFoundException;
import com.richminime.domain.clothing.exception.ClothingUserNotFoundException;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.exception.ForbiddenException;
import com.richminime.global.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import static com.richminime.domain.clothing.constant.ClothingExceptionMessage.*;

@Service
@RequiredArgsConstructor
public class UserClothingServiceImpl implements UserClothingService {

    private final UserClothingRepository userClothingRepository;
    private final ClothingRepository clothingRepository;
    private final UserRepository userRepository;
    private final BankBookRepository bankBookRepository;
    private final SecurityUtils securityUtils;

    private User getLoggedInUser() {
        String loggedInUserEmail = securityUtils.getLoggedInUserEmail();
        return userRepository.findByEmail(loggedInUserEmail)
                .orElseThrow(() -> new ClothingUserNotFoundException(CLOTHING_USER_NOT_FOUND.getMessage()));
    }

    private void checkUserOwnership(User loggedInUser, User targetUser) {
        if (!loggedInUser.getUserId().equals(targetUser.getUserId())) {
            throw new ForbiddenException(CLOTHING_AUTHORIZATION_FAILED.getMessage());
        }
    }

    @Transactional
    @Override
    public AddUserClothingResDto addMyClothing(Long clothingId) {
        User user = getLoggedInUser();

        Clothing clothing = clothingRepository.findById(clothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        boolean alreadyOwned = userClothingRepository.existsByUser_UserIdAndClothing_ClothingId(user.getUserId(), clothing.getClothingId());

        if (user.getClothingCount() >= 20) {
            throw new ClothingDuplicatedException(CLOTHING_COUNT_OVER.getMessage());
        }

        if (alreadyOwned) {
            throw new ClothingDuplicatedException(CLOTHING_DUPLICATED.getMessage());
        }

        long newBalance = user.getBalance() - clothing.getPrice();
        if (newBalance < 0) {
            throw new ClothingInsufficientBalanceException(CLOTHING_INSUFFICIENT_BALANCE.getMessage());
        }

        BankBook bankBook = BankBook.builder()
                .userId(user.getUserId())
                .amount(clothing.getPrice())
                .date(LocalDate.now())
                .balance(newBalance)
                .transactionType(TransactionType.getTransactionType("구매"))
                .summary(clothing.getClothingName() + " 구매")
                .build();

        bankBookRepository.save(bankBook);
        user.updateBalance(newBalance);

        boolean buy = true;
        user.updateClothingCnt(buy);

        UserClothing userClothing = UserClothing.builder()
                .clothing(clothing)
                .user(user)
                .build();

        userClothingRepository.save(userClothing);
        userRepository.save(user);
        return AddUserClothingResDto.entityToDto(userClothing);
    }

    @Transactional
    @Override
    public DeleteUserClothingResDto deleteMyClothing(Long userClothingId) {
        UserClothing userClothing = userClothingRepository.findById(userClothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        User loggedInUser = getLoggedInUser();
        checkUserOwnership(loggedInUser, userClothing.getUser());

        long saleAmount = Math.round(userClothing.getClothing().getPrice() * 0.4);
        long newBalance = loggedInUser.getBalance() + saleAmount;

        BankBook bankBook = BankBook.builder()
                .userId(loggedInUser.getUserId())
                .amount(saleAmount)
                .date(LocalDate.now())
                .balance(newBalance)
                .transactionType(TransactionType.getTransactionType("판매"))
                .summary(userClothing.getClothing().getClothingName() + " 판매")
                .build();

        bankBookRepository.save(bankBook);
        loggedInUser.updateBalance(newBalance);

        boolean sell = false;
        loggedInUser.updateClothingCnt(sell);

        userRepository.save(loggedInUser);
        userClothingRepository.delete(userClothing);
        return DeleteUserClothingResDto.entityToDto(userClothing);
    }

    @Transactional
    @Override
    public List<UserClothingResDto> findAllMyClothingByType(ClothingType clothingType) {
        User loggedInUser = getLoggedInUser();
        //기본이미지
        Long excludeClothingId = 100_000L;

        List<UserClothing> userClothingList;
        if (clothingType == null) {
            userClothingList = userClothingRepository.findAllByUser_UserIdAndClothing_ClothingIdNot(loggedInUser.getUserId(), excludeClothingId);
        } else {
            userClothingList = userClothingRepository.findAllByUser_UserIdAndClothing_ClothingTypeAndClothing_ClothingIdNot(loggedInUser.getUserId(), clothingType, excludeClothingId);
        }

        List<UserClothingResDto> userClothingResDtoList = new ArrayList<>();
        for (UserClothing userClothing : userClothingList) {
            userClothingResDtoList.add(UserClothingResDto.entityToDto(userClothing));
        }
        return userClothingResDtoList;
    }
}
