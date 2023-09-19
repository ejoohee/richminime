package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class CheckEmailResDto {

    private Boolean success;

    @Builder
    public CheckEmailResDto(Boolean success) {
        this.success = success;
    }

}
