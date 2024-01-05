package com.richminime.domain.clothing.constant;

public enum ClothingResponseMessage {
    ADD_CLOTHING("의상 등록 완료했습니다."),
    UPDATE_CLOTHING("의상 수정 완료했습니다."),
    DELETE_CLOTHING("의상 삭제 완료했습니다."),
    FIND_ALL_CLOTHING("의상 목록 조회 완료했습니다."),
    FIND_ONE_CLOTHING("의상 상세 조회 완료했습니다."),

    ADD_MY_CLOTHING("의상 구매 완료했습니다."),
    DELETE_MY_CLOTHING("의상 판매 완료했습니다."),
    FIND_ALL_MY_CLOTHING("내가 보유한 의상 목록 조회 완료했습니다.");


    private final String message;

    ClothingResponseMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}
