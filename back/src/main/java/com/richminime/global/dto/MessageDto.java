package com.richminime.global.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MessageDto {

    String msg;

    public static MessageDto msg(String msg) {
        return MessageDto.builder().msg(msg).build();
    }
}
