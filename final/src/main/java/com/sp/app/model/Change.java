package com.sp.app.model;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class Change {

    private long changeNum; // 교환번호
    private long memberIdx; // 회원코드
    private long itemCode; // 상품주문번호
    private String changeRequest; // 변경요청사항
    private int changeState; // 상태
    private String changeDate; // 날짜
    private String orderCode;
    private String thumbnail;
    private String item;
    private String brandName;

}
