package com.richminime.domain.user.service;

import com.richminime.domain.user.dto.request.AddUserReqDto;
import com.richminime.domain.user.dto.request.GenerateConnectedIdReqDto;
import com.richminime.domain.user.dto.request.LoginReqDto;
import com.richminime.domain.user.dto.response.CheckEmailResDto;
import com.richminime.domain.user.dto.response.GenerateConnectedIdResDto;
import com.richminime.domain.user.dto.response.LoginResDto;

public interface UserService {

    void addUser(AddUserReqDto addUserRequest);

    LoginResDto login(LoginReqDto loginRequest);

    CheckEmailResDto checkEmail(String email);

    GenerateConnectedIdResDto generateConnectedId(GenerateConnectedIdReqDto generateConnectedIdRequest);

    void logout(String email, String accessToken);

}
