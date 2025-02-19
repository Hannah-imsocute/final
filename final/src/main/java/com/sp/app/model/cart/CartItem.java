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

  private Integer couponValue = 0;
  private Integer spentPoint = 0;
}
//  <svg data-v-6d2bd019="" data-v-ec764313=""
//width="24" height="24" viewBox="0 0 24 24"
//xmlns="http://www.w3.org/2000/svg" class="BaseIcon"
//style="width: 24px; height: 24px; opacity: 1; fill: currentcolor; --BaseIcon-color: #333333;">
//                                    <g clip-path="url(#clip0_124_2947)">
//                                        <path fill-rule="evenodd" clip-rule="evenodd" d="M9.53039 5.46973L15.5304 11.4697C15.7967 11.736 15.8209 12.1527 15.603 12.4463L15.5304 12.5304L9.53039 18.5304L8.46973 17.4697L13.9391 12.0001L8.46973 6.53039L9.53039 5.46973Z"></path>
//                                    </g>
//                                    <defs>
//                                        <clipPath id="clip0_124_2947">
//                                            <rect width="24" height="24"></rect>
//                                        </clipPath>
//                                    </defs>
//                                </svg>