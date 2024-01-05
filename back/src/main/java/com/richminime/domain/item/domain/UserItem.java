package com.richminime.domain.item.domain;

import com.richminime.domain.user.domain.User;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;

@Builder
@DynamicInsert
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Entity
public class UserItem {

    @Id @GeneratedValue
    @Column(name = "user_item_id")
    private Long userItemId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "item_id")
    private Item item;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    
}
