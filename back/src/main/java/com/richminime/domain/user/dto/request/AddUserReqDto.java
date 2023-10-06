package com.richminime.domain.user.dto.request;

import com.richminime.domain.user.domain.User;
import com.richminime.domain.user.domain.UserType;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import java.util.Date;
import java.util.UUID;

@Getter
@Setter
public class AddUserReqDto {

    @Email
    private String email;

    @Length(min = 8, max = 16, message = "비밀번호는 최소 8글자 최대 16글자 입니다.")
    private String password;

    private String nickname;

    private String organization;

    @Pattern(regexp = "^[0-9]+$", message = "숫자만 입력해주세요")
    private String cardNumber;

    private String uuid;

    public User toEntity(String connectedId, String organizationCode){
        return User.builder()
                .email(this.email)
                .password(this.password)
                .nickname(this.nickname)
                .connectedId(connectedId)
                .organizationCode(organizationCode)
                .cardNumber(this.cardNumber)
                // 관리자는 별도로 생성할 예정
                // 기본값 ROLE_USER
                .userType(UserType.ROLE_USER.getValue())

                .build();
    }


}
