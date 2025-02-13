package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class MemberPoint {

    private long memberIdx; // 회원코드
    private int saveAount; // 포인트금액
    private String saveDate; // 포인트적립일
    private String expireDate; // 포인트사용일
    private String reason; // 적립경로
    private int enable; // 사용가능여부
    private int balance; // 사용가능금액

    private int useAmount; // 사용포인트 금액
    private String useDate; // 사용일자

    private int pointBalance; // 현재 보유 포인트
    private int pointAmount; // 포인트금액?

}
