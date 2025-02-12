package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Seller {
  private long brandCode; // 브랜드번호
  private long memberIdx; // 회원코드
  private String phone; // 업무전화번호
  private String brandName; // 브랜드명
  private String brandIntro; // 브랜드설명
  private int enable; // 차단여부
  private int reportCount; // 정지횟수

  private String bank; // 은행명
  private String accNumber; // 계좌번호
  private String accImage; // 통장사본
}
