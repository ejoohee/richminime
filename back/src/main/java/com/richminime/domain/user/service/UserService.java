package com.richminime.domain.user.service;

import com.richminime.domain.user.dto.request.AddUserRequest;
import com.richminime.domain.user.dto.request.GenerateConnectedIdRequest;
import com.richminime.domain.user.dto.request.LoginRequest;
import com.richminime.domain.user.dto.response.CheckEmailResponse;
import com.richminime.domain.user.dto.response.GenerateConnectedIdResponse;
import com.richminime.domain.user.dto.response.LoginResponse;

public interface UserService {

    void addUser(AddUserRequest addUserRequest);

    LoginResponse login(LoginRequest loginRequest);

    CheckEmailResponse checkEmail(String email);

    GenerateConnectedIdResponse generateConnectedId(GenerateConnectedIdRequest generateConnectedIdRequest);

}
