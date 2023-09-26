package com.richminime.domain.character.domain;

import com.richminime.domain.clothing.domain.Clothing;
import com.richminime.domain.user.domain.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Character {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "character_id")
    private Long characterId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "clothing_id")
    private Clothing clothing;

    public void chageClothing(Clothing clothing){
        this.clothing = clothing;
    }

}
