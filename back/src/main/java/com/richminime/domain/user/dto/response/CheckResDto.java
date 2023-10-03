package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class CheckResDto {

    private Boolean success;

    @Builder
    public CheckResDto(Boolean success) {
        this.success = success;
    }

}
