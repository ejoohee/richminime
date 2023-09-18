package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.UUID;

public class GenerateConnectedIdResponse {

    UUID uuid;

    @Builder
    public GenerateConnectedIdResponse(UUID uuid) {
        this.uuid = uuid;
    }

}
