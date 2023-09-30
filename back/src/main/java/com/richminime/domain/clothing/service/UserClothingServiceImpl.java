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
import com.richminime.domain.clothing.dto.UserClothingReqDto;
import com.richminime.domain.clothing.dto.UserClothingResDto;
import com.richminime.domain.clothing.exception.ClothingDuplicatedException;
import com.richminime.domain.clothing.exception.ClothingNotFoundException;
import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.exception.UserNotFoundException;
import com.richminime.domain.user.repository.UserRepository;
import com.richminime.global.exception.ForbiddenException;
import com.richminime.global.exception.InsufficientBalanceException;
import com.richminime.global.util.SecurityUtils;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import static com.richminime.domain.clothing.constant.ClothingExceptionMessage.*;
import static com.richminime.domain.user.exception.UserExceptionMessage.USER_NOT_FOUND;
import static com.richminime.global.constant.ExceptionMessage.INSUFFICINET_BALANCE;

@Service
@RequiredArgsConstructor
public class UserClothingServiceImpl implements UserClothingService {

    private final UserClothingRepository userClothingRepository;
    private final ClothingRepository clothingRepository;
    private final UserRepository userRepository;
    private final BankBookRepository bankBookRepository;
    private final SecurityUtils securityUtils;

    @Transactional
    @Override
    public AddUserClothingResDto addMyClothing(UserClothingReqDto userClothingReqDto) {

        String loggedInUserEmail = securityUtils.getLoggedInUserEmail();

        User user = userRepository.findByEmail(loggedInUserEmail)
                .orElseThrow(() -> new UserNotFoundException(USER_NOT_FOUND.getMessage()));

        long clothingId = userClothingReqDto.getClothingId();
        Clothing clothing = clothingRepository.findById(clothingId)
                .orElseThrow(() -> new ClothingNotFoundException(CLOTHING_NOT_FOUND.getMessage()));

        boolean alreadyOwned = userClothingRepository.existsByUser_UserIdAndClothing_ClothingId(user.getUserId(), clothing.getClothingId());

        //만약 보유 옷 20개 넘으면 못사게 예외
        if (user.getClothingCount() >= 20) {
            throw new ClothingDuplicatedException(CLOTHING_COUNT_OVER.getMessage());
        }

        //구매한 적 있으면 못사게 예외
        if (alreadyOwned) {
            throw new ClothingDuplicatedException(CLOTHING_DUPLICATED.getMessage());
        }

        long newBalance = user.getBalance() - clothing.getPrice();

        //잔액부족
        if (newBalance < 0)
            throw new InsufficientBalanceException(INSUFFICINET_BALANCE.getMessage());

        BankBook bankBook = BankBook.builder()
                .userId(user.getUserId())
                .amount(clothing.getPrice())
                .date(LocalDate.now())
                .balance(newBalance)
                .transactionType(TransactionType.getTransactionType("구매"))
                .summary(clothing.getClothingInfo())
                .build();

        bankBookRepository.save(bankBook);
        user.updateBalance(newBalance);

        //ture면 사는거
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

        String loggedInUserEmail = securityUtils.getLoggedInUserEmail();

        User user = userRepository.findByEmail(loggedInUserEmail)
                .orElseThrow(() -> new UserNotFoundException(USER_NOT_FOUND.getMessage()));

        // 로그인 유저와 소유자가 동일한지 체크
        if (!user.getUserId().equals(userClothing.getUser().getUserId())) {
            throw new ForbiddenException();
        }

        long saleAmount = Math.round(userClothing.getClothing().getPrice() * 0.4);
        long newBalance = user.getBalance() + saleAmount;

        BankBook bankBook = BankBook.builder()
                .userId(user.getUserId())
                .amount(saleAmount)
                .date(LocalDate.now())
                .balance(newBalance)
                .transactionType(TransactionType.getTransactionType("판매"))
                .summary(userClothing.getClothing().getClothingInfo())
                .build();

        bankBookRepository.save(bankBook);
        user.updateBalance(newBalance);

        //false면 파는거
        boolean sell = false;
        user.updateClothingCnt(sell);

        userRepository.save(user);
        userClothingRepository.delete(userClothing);
        return DeleteUserClothingResDto.entityToDto(userClothing);
    }

    @Transactional
    @Override
    public List<UserClothingResDto> findAllMyClothingByType(ClothingType clothingType) {
        String loggedInUserEmail = securityUtils.getLoggedInUserEmail();

        User user = userRepository.findByEmail(loggedInUserEmail)
                .orElseThrow(() -> new UserNotFoundException(USER_NOT_FOUND.getMessage()));

        if (clothingType == null) {
            List<UserClothing> userClothingList = userClothingRepository.findAllByUser_UserId(user.getUserId());
            List<UserClothingResDto> userClothingResDtoList = new ArrayList<>();
            for (UserClothing userClothing : userClothingList) {
                UserClothingResDto dto = UserClothingResDto.entityToDto(userClothing);
                userClothingResDtoList.add(dto);
            }
            return userClothingResDtoList;
        } else {
            List<UserClothing> userClothingListByType = userClothingRepository.findAllByUser_UserIdAndClothing_ClothingType(user.getUserId(), clothingType);
            List<UserClothingResDto> userClothingResDtoListByType = new ArrayList<>();
            for (UserClothing userClothing : userClothingListByType) {
                UserClothingResDto dto = UserClothingResDto.entityToDto(userClothing);
                userClothingResDtoListByType.add(dto);
            }
            return userClothingResDtoListByType;
        }
    }
}