package com.richminime.domain.room.domain;


import com.richminime.domain.item.domain.Item;
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
public class Room {
    @Id @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "room_id")
    private Long roomId;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id")
    private Item item;

    public void chageItem(Item item){
        this.item = item;
    }

}
