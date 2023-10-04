package com.richminime.global.common.codef;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * codef api 반환 결과의 에러코드를 나타내는 enum 클래스
 */
@Getter
@AllArgsConstructor
public enum CodefErrorCode {

    CARD_NO_INVALID("CF-13101");

    String code;

}
