package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Getter
@NoArgsConstructor
public class GenerateConnectedIdResDto {

    private UUID uuid;

    @Builder
    public GenerateConnectedIdResDto(UUID uuid) {
        this.uuid = uuid;
    }

}
