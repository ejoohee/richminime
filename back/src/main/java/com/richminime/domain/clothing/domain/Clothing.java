package com.richminime.domain.clothing.domain;

import com.richminime.domain.clothing.constant.ClothingType;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Clothing {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long clothingId;

    @Column(nullable = false, length = 40)
    private String clothingName;

    @Enumerated(value = EnumType.STRING)
    private ClothingType clothingType;

    @Column(nullable = false)
    private String clothingImg;

    @Column(nullable = false)
    private String clothingApplyImg;

    @Column(length = 40)
    private String clothingInfo;

    @Column(columnDefinition = "BIGINT DEFAULT 0")
    private long price;

    @OneToMany(mappedBy = "clothing")
    private List<UserClothing> userClothings = new ArrayList<>();

    @Builder
    public Clothing(Long clothingId, String clothingName, ClothingType clothingType, String clothingImg, String clothingApplyImg, String clothingInfo, Long price) {
        this.clothingId = clothingId;
        this.clothingName = clothingName;
        this.clothingType = clothingType;
        this.clothingImg = clothingImg;
        this.clothingApplyImg = clothingApplyImg;
        this.clothingInfo = clothingInfo;
        this.price = price;
    }

    public void update(String clothingName, ClothingType clothingType, String clothingImg, String clothingApplyImg, String clothingInfo, Long price) {
        this.clothingName = clothingName;
        this.clothingType = clothingType;
        this.clothingImg = clothingImg;
        this.clothingApplyImg = clothingApplyImg;
        this.clothingInfo = clothingInfo;
        this.price = price;
    }
}