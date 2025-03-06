package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MyPage {

  private String orderCode;
  private String orderState; // 주문상태
  private String packageState; // 배송상태
  private String productName; // 상품명
  private String orderDate;
  private String brandName;
  private long quantity;
  private long netPay;
  private long memberIdx;
  private String thumbnail; // 상품이미지
  private int price;
  private long productCode;
  private int reviewCount;
  private long itemCode;
  private String addrTitle;
  private String addrDetail;
  private String receiverName;
  private String phone;
  private String bymethod;
  private long cardNumber;
  private String provider;
  private int shipping;
  private double discount;
  private int priceforeach;
  private String confirmCode; // 승인코드
  private String confirmDate; // 승인날짜
  private boolean requested; // 신청 했는지 여부
}
