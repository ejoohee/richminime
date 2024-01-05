package com.richminime.domain.item.repository;

import com.querydsl.core.types.dsl.BooleanExpression;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.richminime.domain.item.domain.Item;
import com.richminime.domain.item.dto.ItemSearchCondition;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import java.util.List;

import static com.richminime.domain.item.domain.QItem.item;
import static com.richminime.domain.item.domain.QUserItem.userItem;

@Repository
@RequiredArgsConstructor
public class ItemQueryDslRepository {

    private final JPAQueryFactory jpaQueryFactory;

    public List<Item> findByCondition(ItemSearchCondition condition) {

        return null;
    }

    /**
     * 해당 이름을 포함하는 아이템만 반환
     * @param name
     * @return
     */

    private BooleanExpression containsNameInItem(String name) {
        if(name == null)
            return null; // 따로 작성 안하면 무시함

        return item.itemName.contains(name)
                .or(item.itemName.startsWith(name))
                .or(item.itemName.endsWith(name));
    }

    /**
     * 해당 이름을 포함하는 유저아이템만 반환
     * @param name
     * @return
     */
    private BooleanExpression containsNameInUserItem(String name) {
        if(name == null)
            return null;

        return userItem.item.itemName.contains(name)
                .or(userItem.item.itemName.startsWith(name))
                .or(userItem.item.itemName.endsWith(name));
    }


}
