package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Getter
@NoArgsConstructor
public class GenerateConnectedIdResponse {

    private UUID uuid;

    @Builder
    public GenerateConnectedIdResponse(UUID uuid) {
        this.uuid = uuid;
    }

}
