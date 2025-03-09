package com.sp.app.model;

import lombok.*;

import java.util.List;

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

    private String brandName;
    private String item;
    private String thumbnail;
    private double discount;

    // 주문 상태: 0 - 주문접수, 1 - 결제완료, 2 - 배송준비중, 3 - 부분배송, 4 - 전체배송완료 등
    private int orderState;

    // 추가적으로 부분취소, 환불, 교환 상태 필드 추가 (예시)
    private int cancelState;    // 0: 정상, 1: 취소요청, 2: 취소완료
    private int refundState;    // 0: 미환불, 1: 환불요청, 2: 환불완료
    private int exchangeState;  // 0: 미교환, 1: 교환요청, 2: 교환완료
    private Integer spentPoint;       //  사용 포인트
    private Integer couponValue;


    private List<Long> productCodes;
    private List<Integer> quantities;
    private List<Long> itemCodes;

}