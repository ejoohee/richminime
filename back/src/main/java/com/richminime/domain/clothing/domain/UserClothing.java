package com.richminime.domain.clothing.domain;

import com.richminime.domain.user.domain.User;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class UserClothing {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userClothingId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "clothing_id")
    private Clothing clothing;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @Builder
    public UserClothing(Long userClothingId, Clothing clothing, User user) {
        this.userClothingId = userClothingId;
        this.clothing = clothing;
        this.user = user;
    }
}
