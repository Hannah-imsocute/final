package com.sp.app.model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Coupon {
    private long memberIdx; // 회원코드
    private String couponCode; // 쿠폰 코드
    private String couponName;    //  쿠폰 이름
    private int couponRate;      //  쿠폰 할인 금액
    private int couponValue;
    private int couponValid; // 쿠폰 사용여부
    private String couponStart; // 쿠폰 시작일
    private String expireDate; // 쿠폰 종료일
    private String usedDate; // 쿠폰 사용일
    private int eventArticleNum; // 이벤트 글번호 -> 어떤 이벤트로 쿠폰이 발급됐는지
}
