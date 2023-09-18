package com.richminime.global.common.codef.dto.response;

import com.richminime.global.common.codef.dto.request.AccountDto;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CreateConnectedIdResponse {

    private String connectedId;

    private List<SuccessDto> successList;

    private List<ErrorDto> errorList;

}
