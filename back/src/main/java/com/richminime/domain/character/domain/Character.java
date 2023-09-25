package com.richminime.domain.character.domain;

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

    @JoinColumn(name = "user_id")
    private Long userId;

    @Column(name = "character", columnDefinition = "VARCHAR(255) DEFAULT '' ")
    private String character;


}
