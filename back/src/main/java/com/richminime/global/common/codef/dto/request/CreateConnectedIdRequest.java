package com.richminime.global.common.codef.dto.request;

import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class CreateConnectedIdRequest {

    List<AccountDto> accountList;


    public CreateConnectedIdRequest() {
        this.accountList = new ArrayList<>();
    }

}
