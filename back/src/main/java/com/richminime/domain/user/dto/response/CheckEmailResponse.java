package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
public class CheckEmailResponse {

    private Boolean success;
    private String message;

    @Builder
    public CheckEmailResponse(Boolean success, String message) {
        this.success = success;
        this.message = message;
    }

}
