package com.richminime.domain.user.dto.request;

import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.domain.UserType;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotBlank;
import java.util.Date;
import java.util.UUID;

@Getter
@Setter
public class AddUserReqDto {

    private String email;

    private String password;

    private String nickname;

    private String organization;

    private String cardNumber;

//    private Date birthDate;

    private UUID uuid;

    public User toEntity(String connectedId, String organizationCode){
        return User.builder()
                .email(this.email)
                .password(this.password)
                .nickname(this.nickname)
                .connectedId(connectedId)
                .organizationCode(organizationCode)
                .cardNumber(this.cardNumber)
//                .birthDate(this.birthDate)
                // 관리자는 별도로 생성할 예정
                // 기본값 ROLE_USER
                .userType(UserType.ROLE_USER.getValue())
                .build();
    }


}
