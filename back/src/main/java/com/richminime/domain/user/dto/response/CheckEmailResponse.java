package com.richminime.domain.user.dto.response;

import lombok.Builder;

public class CheckEmailResponse {

    private Boolean success;

    @Builder
    public CheckEmailResponse(Boolean success) {
        this.success = success;
    }

}
