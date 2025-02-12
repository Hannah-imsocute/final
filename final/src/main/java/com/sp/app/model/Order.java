package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Order {

  private long orderCode; // 주문번호
  private String orderDate; // 주문일시
  private String addrNum; // 기본 배송지 주소
  private int totalPrice; // 총 주문 금액
  private String couponCode; // 쿠폰 코드
  private int couponValue; // 쿠폰 가격 ?
  private int spentPoint; // 포인트 사용 금액
  private int netPay; // 결제 금액
  private String confirmDate; // 주문확인날짜

  private long memberIdx; // 회원코드
  private String email; // 회원 ID
  private String payment; // 결제수단




}
