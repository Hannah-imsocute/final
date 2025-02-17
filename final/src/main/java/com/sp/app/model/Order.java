package com.sp.app.model;

import lombok.*;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {

  /*Order*/
  private String orderCode;       // 주문번호
  private long memberIdx;       // 회원 번호
  private String email;         // 회원 이메일
  private String orderDate;     // 주문일시
  private int addrNum;       // 배송지 주소
  private int totalPrice;       // 전체 주문 금액

  private String couponCode; // 쿠폰 코드
  private String couponName;    //  쿠폰 이름
  private int couponRate;      //  쿠폰 할인 금액
  private int couponValue;
  private int couponValid; // 쿠폰 사용여부
  private String couponStart; // 쿠폰 시작일
  private String expireDate; // 쿠폰 종료일


  private int spentPoint;       //  사용 포인트
  private int netPay;           // 최종 결제 금액
  private String confirmDate;   // 주문 확인일시
  private String payment;       // 결제 수단
  private List<OrderItem> orderItems; // 개별 주문 항목 리스트

  /*OrderItem*/
  private long productCode;
  private int price;
  private String options1; // 옵션
  private String options2; // 옵션
  private int priceForeach; //  단가
  private int quantity; // 수량
  private int shipping; // 배송비
  private int orderState; // 주문상태
  private double discount; // 할인율

  /*ShippingInfo*/
  private String receiverName; // 수령인 이름
  private String postCode; // 우편번호
  private String addName; // 배송지 ex:집
  private String addTitle; // 배송지 주소 ex: 서울특별시 마포구
  private String addDetail; // 배송지 상세 주소 ex:101
  private String phone;         // 연락처
  private Integer firstAdd; // 기본 배송지 등록 1 - 기본


  /*Payment*/
  private String confirmCode; // 승인번호
  private String provider; // 카드사
  private String byMethod; // 결제수단
  private String cardNumber; // 카드번호
}
