package com.sp.app.model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ShippingInfo {
  private Long memberIdx;      // 회원 번호
  private String receiverName; // 수령인 이름
  private String addName; // 배송지 ex:집
  private String addTitle; // 배송지 주소 ex: 서울특별시 마포구
  private String addDetail; // 배송지 상세 주소 ex:101
  private String phone;         // 연락처
  private Integer firstAdd; // 기본 배송지 등록 1 - 기본
}
