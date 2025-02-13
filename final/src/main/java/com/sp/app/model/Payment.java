package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Payment {
  private long orderCode; // 주문번호
  private long memberIDx; // 회원번호
  private String confirmCode; // 승인번호
  private String provider; // 카드사
  private String byMethod; // 결제수단
  private String confirmDate; // 승인날짜
  private String cardNumber; // 카드번호

}
