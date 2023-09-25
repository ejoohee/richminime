package com.richminime.domain.user.domain;


import com.richminime.domain.gpt.domain.Prompt;
import com.richminime.domain.user.dto.request.UpdateUserReqDto;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.DynamicInsert;
import com.richminime.domain.gpt.domain.Prompt;
import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter
@DynamicInsert
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "users")
@Entity
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long userId;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String password;

    @Column(length = 20, nullable = false)
    private String nickname;

    @Column(columnDefinition = "long default 0")
    private long balance;

    @Column(nullable = false)
    private String connectedId;

    @Column(length = 4, nullable = false)
    private String organizationCode;

    @Column(nullable = false)
    private String cardNumber;

    @Column(nullable = false, columnDefinition = "varchar(50)")
    @ColumnDefault("'ROLE_USER'")
    @Enumerated(EnumType.STRING)
    private UserType userType;

    @Column(name = "clothing_count", columnDefinition = "integer default 0")
    private Integer clothingCount;

    @Column(name = "item_count", columnDefinition = "integer default 0")
    private Integer itemCount;

//    @Column(nullable = false)
//    private Date birthDate;

    @OneToMany(mappedBy = "promptId")
    private List<Prompt> prompts = new ArrayList<>();

    @Builder
    public User(String email, String password, String nickname, String connectedId, String organizationCode, String cardNumber, String userType) {
        this.email = email;
        this.password = password;
        this.nickname = nickname;
        this.connectedId = connectedId;
        this.organizationCode = organizationCode;
        this.cardNumber = cardNumber;
        this.userType = UserType.getUserType(userType);
//        this.birthDate = birthDate;
    }

    /**
     * 비즈니스 메서드
     */

    // 잔액 업데이트
    public void updateBalance(long balance) {
        this.balance = balance;
    }

    // 회원 정보 업데이트
    public void updateUser(UpdateUserReqDto updateUserReqDto){
        this.nickname = updateUserReqDto.getNickname();
    }

    // 비밀번호 업데이트
    public void updatePassword(String encrypted) {
        this.password = encrypted;
    }

    // 아이템 카운트 업데이트
    public void updateItemCnt(boolean isBuy) {
        if(isBuy)
            this.itemCount++;
        else
            this.itemCount--;

//        if(itemCount > 20) { 서비스단 구현 }
    }

    // 클로징 카운트 업데이트
    public void updateClothingCnt(boolean isBuy) {
        if(isBuy)
            this.clothingCount++;
        else
            this.clothingCount--;
    }

}
