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
  private long brandCode;
  private long memberIdx;
  private String phone;
  private String brandName;
  private String brandIntro;
  private int enable;
  private int reportCount;
}
