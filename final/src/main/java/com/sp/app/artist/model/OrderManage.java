package com.sp.app.artist.model;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class OrderManage {
    private String order_code;
    private String item_code;
    private long memberIdx;
    private String userId;
    private String nickname;
    private String order_date;

    private int totalMoney; //상품구매 금액
    private int spentPoint; //적립금사용액
    private int shipping;//배송비
    private int netPay;//최종금액 (상품구매+배송비-적립금사용액)
    private int refund_amount; //취소금액(환불및 취소 금액)
    private int orderState; //주문상태
    private String orderStateInfo;//모르겠음

    private String orderStateDate;//상태변경일자
    private String company_name; //택배사이름
    private String trackingNumber;//송장번호

    private int totalOrderCount;  //주문상품수
    private int totalQty; //상품 주문 개수
    private int detailCancelCount; //취소건수(판매취소 , 주문취소완료,반품접수,반품완료)
    private int cancelRequestCount;//배송전 주문 취소 요청수, 반품 요청수
    private int exchangeRequestCount;//배송후 교환 요청수


    //결제 정보
    private String payMethod;
    private String cardName;

    private String authNumber;
    private String authDate;
}



