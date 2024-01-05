package com.richminime.domain.user.service;

import com.richminime.domain.user.dto.request.*;
import com.richminime.domain.user.dto.response.*;

import java.util.List;
import java.util.Map;

public interface UserService {

    void addUser(AddUserReqDto addUserRequest);

    LoginResDto login(LoginReqDto loginRequest);

    CheckResDto checkEmail(String email);

    GenerateConnectedIdResDto generateConnectedId(GenerateConnectedIdReqDto generateConnectedIdRequest);

    void logout(String accessToken);

    void sendEmailCode(String email);

    CheckResDto checkEmailCode(CheckEmailCodeReqDto checkEmailCodeReqDto);

    ReissueTokenResDto reissueToken(String accessToken, String refreshToken);

    void updateUser(UpdateUserReqDto updateUserReqDto);

    void deleteUser();

    FindUserResDto findUser();

    FindBalanceResDto findBalance();

    void updateBalance(Long balance);

    List<FindUserResDto> findUserList();

    void deleteUser(String email);

    void updatePassword(UpdatePasswordReqDto updatePasswordReqDto);

    CheckResDto checkCardNumber(CheckCardNumberReqDto checkCardNumberReqDto);

}
