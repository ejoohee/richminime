package com.richminime.domain.user.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.UUID;

@Getter
public class GenerateConnectedIdResponse {

    private UUID uuid;
    private String message;

    @Builder
    public GenerateConnectedIdResponse(UUID uuid, String message) {
        this.uuid = uuid;
        this.message = message;
    }

}
