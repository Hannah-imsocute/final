package com.sp.app.model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Payment {
  private long memberIdx; // 회원번호
  private String orderCode; // 주문번호
  private String byMethod; // 결제수단
  private long confirmCode; // 승인번호
  private String provider; // 카드사
  private String confirmDate; // 승인날짜
  private String cardNumber; // 카드번호
  private long payment; // 결제할총금액
}
