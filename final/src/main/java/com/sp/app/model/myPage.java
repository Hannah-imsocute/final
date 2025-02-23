package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class myPage {

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

}
