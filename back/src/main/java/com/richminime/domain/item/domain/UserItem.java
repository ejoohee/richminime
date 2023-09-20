package com.richminime.domain.item.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.apache.catalina.User;
import org.hibernate.annotations.DynamicInsert;

import javax.persistence.*;
import java.util.List;

@Builder
@DynamicInsert
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Entity
public class UserItem {

    // userItemId, itemId, userId 포린키

    @Id @GeneratedValue
    @Column(name = "user_item_id")
    private Long userItemId;

    @OneToMany(mappedBy = "itemId" , fetch = FetchType.LAZY)
    private List<Item> item;

//    @OneToOne(mappedBy = "")
//    private User user;

    
}
