package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class CheckEmailResponse {

    private Boolean success;

    @Builder
    public CheckEmailResponse(Boolean success) {
        this.success = success;
    }

}
