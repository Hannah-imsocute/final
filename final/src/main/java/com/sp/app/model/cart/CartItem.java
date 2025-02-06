package com.sp.app.model.cart;

import lombok.*;


@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItem {
  private Long CartItemCode; // 아이템코드
  private Long memberIdx;     // 회원 ID
  private Long productCode;   // 상품 코드
  private Integer quantity;   // 수량
  private Integer price;      // 가격
  private String created;       // 생성일
}
