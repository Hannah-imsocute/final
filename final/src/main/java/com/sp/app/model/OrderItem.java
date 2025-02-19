package com.sp.app.model;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderItem {
    private long itemCode;      // 주문 항목 코드
    private String orderCode;     // 연결된 주문 번호
    private long productCode;   // 상품 코드
    private String options;     // 상품 옵션
    private int priceForeach;   // 단가
    private int quantity;       // 수량
    private int price;          // 상품 금액 (priceForeach * quantity)
    private int shipping;       // 배송비
    private int orderState;     // 주문 상태
    private Integer spentPoint;       //  사용 포인트
    private Integer couponValue;


}