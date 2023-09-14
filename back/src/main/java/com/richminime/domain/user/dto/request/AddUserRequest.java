package com.richminime.domain.user.dto.request;

import com.richminime.domain.user.domain.User;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class AddUserRequest {

    private String email;
    private String password;
    private String nickname;
    private String organization;
    private String cardNumber;
    private Date birthDate;

    @Builder
    public AddUserRequest(String email, String password, String nickname, String organization, String cardNumber, Date birthDate) {
        this.email = email;
        this.password = password;
        this.nickname = nickname;
        this.organization = organization;
        this.cardNumber = cardNumber;
        this.birthDate = birthDate;
    }

    public User toEntity(String connectedId, String organizationCode){
        return User.builder()
                .email(this.email)
                .password(this.password)
                .nickname(this.nickname)
                .connectedId(connectedId)
                .organizationCode(organizationCode)
                .cardNumber(this.cardNumber)
                .birthDate(this.birthDate)
                .build();
    }


}
