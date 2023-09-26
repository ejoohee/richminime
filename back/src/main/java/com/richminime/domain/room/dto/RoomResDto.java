package com.richminime.domain.room.dto;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RoomResDto {

    private Long roomId;

    private String imgURL;


}
