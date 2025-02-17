package com.sp.app.model;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {

  private String orderCode;       // 주문번호`
  private long memberIdx;       // 회원 번호
  private String email;         // 회원 이메일
  private String orderDate;     // 주문일시
  private int addrNum;       // 배송지 주소
  private int totalPrice;       // 전체 주문 금액
  private String couponCode;    //  쿠폰 코드
  private int couponValue;      //  쿠폰 할인 금액
  private int spentPoint;       //  사용 포인트
  private int netPay;           // 최종 결제 금액
  private String confirmDate;   // 주문 확인일시
  private String payment;       // 결제 수단
  private List<OrderItem> orderItems; // 개별 주문 항목 리스트

  /*
  private long orderCode; // 주문번호
  private long productCode;
  private String orderDate; // 주문일시
  private String addrNum; // 기본 배송지 주소
  private int totalPrice; // 총 주문 금액
  private String couponCode; // 쿠폰 코드
  private int couponValue; // 쿠폰 가격 ?
  private int spentPoint; // 포인트 사용 금액
  private int netPay; // 결제 금액
  private String confirmDate; // 주문확인날짜
  private int price;

  private String options; // 옵션
  private int priceForeach; //  단가
  private int quantity; // 수량
  private int shipping; // 배송비
  private int orderState; // 주문상태

  private long memberIdx; // 회원코드
  private String email; // 회원 ID
  private String payment; // 결제수단
  */
}
