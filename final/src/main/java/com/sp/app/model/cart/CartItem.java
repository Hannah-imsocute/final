package com.sp.app.model.cart;

import lombok.*;


@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItem {
  private Long cartItemCode; // 아이템코드
  private Long memberIdx;     // 회원 ID
  private Long productCode;   // 상품 코드
  private Integer quantity;   // 수량
  private Integer price;      // 가격
  private String item;
  private String created;       // 생성일
  private String cartOption; // 상품 옵션 text 값
}
