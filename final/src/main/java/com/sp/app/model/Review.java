package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Review {
  private long reviewNum; // 리뷰번호
  private long memberIdx;
  private long productCode; // 상품번호
  private String content; // 내용
  private int block;
  private int starRate; // 별점
  
}
