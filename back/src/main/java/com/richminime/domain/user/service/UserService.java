package com.richminime.domain.user.service;

import com.richminime.domain.user.dto.request.*;
import com.richminime.domain.user.dto.response.CheckEmailResDto;
import com.richminime.domain.user.dto.response.FindBalanceResDto;
import com.richminime.domain.user.dto.response.FindUserResDto;
import com.richminime.domain.user.dto.response.GenerateConnectedIdResDto;

import java.util.List;
import java.util.Map;

public interface UserService {

    void addUser(AddUserReqDto addUserRequest);

    Map<String, Object> login(LoginReqDto loginRequest);

    CheckEmailResDto checkEmail(String email);

    GenerateConnectedIdResDto generateConnectedId(GenerateConnectedIdReqDto generateConnectedIdRequest);

    void logout(String email, String accessToken);

    void sendEmailCode(String email);

    CheckEmailResDto checkEmailCode(CheckEmailCodeReqDto checkEmailCodeReqDto);

    Map<String, Object> reissueToken(String accessToken, String refreshToken);

    void updateUser(UpdateUserReqDto updateUserReqDto);

    void deleteUser();

    FindUserResDto findUser();

    FindBalanceResDto findBalance();

    void updateBalance(Long balance);

    List<FindUserResDto> findUserList();

    void deleteUser(String email);

    void updatePassword(UpdatePasswordReqDto updatePasswordReqDto);

}
