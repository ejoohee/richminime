package com.richminime.domain.user.service;

import com.richminime.domain.user.dto.request.AddUserRequest;
import com.richminime.domain.user.dto.response.CheckEmailResponse;

public interface UserService {

    void addUser(AddUserRequest addUserRequest);

    CheckEmailResponse checkEmail(String email);

}
