package com.sp.app.model;

import lombok.*;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {
  private Payment payments;
  private OrderItem orderItem;
  private Coupon coupon;

  private ShippingInfo shippingInfo;
  /*Order*/
  private String orderCode;       // 주문번호
  private long memberIdx;       // 회원 번호
  private String email;         // 회원 이메일
  private String orderDate;     // 주문일시
  private int totalPrice;       // 전체 주문 금액
  private int salePrice; // 세일 가격
  private int savedMoney; // 상품 가격 - 세일 가격 = 할인 가겨
  // 10,000 - 8,000 = 2,000 savedMoney - 2,000


  private String couponCode; // 쿠폰 코드
  private String couponName;    //  쿠폰 이름
  private Integer couponRate;      //  쿠폰 할인 금액
  private Integer couponValue;
  private int couponValid; // 쿠폰 사용여부
  private String couponStart; // 쿠폰 시작일
  private String expireDate; // 쿠폰 종료일


  private Integer spentPoint;       //  사용 포인트
  private int netPay;           // 최종 결제 금액
  private String confirmDate;   // 주문 확인일시
  private String payment;       // 결제 수단

  /*OrderItem*/
  private long productCode;
  private int price;
  private String options1; // 옵션
  private String options2; // 옵션
  private int priceForeach; //  단가
  private int quantity; // 수량
  private int shipping; // 배송비
  private int orderState; // 주문상태
  private double discount; // 할인율

  /*ShippingInfo*/
  private String receiverName; // 수령인 이름
  private String postCode; // 우편번호
  private String addName; // 배송지 ex:집
  private String addTitle; // 배송지 주소 ex: 서울특별시 마포구
  private String addDetail; // 배송지 상세 주소 ex:101
  private String phone;         // 연락처
  private Integer firstAdd; // 기본 배송지 등록 1 - 기본


  /*Payment*/
  private String confirmCode; // 승인번호
  private String provider; // 카드사
  private String byMethod; // 결제수단
  private String cardNumber; // 카드번호

  private List<String> optionNames; //  옵션이름
  private List<String> optionNames2; // 옵션이름
  private List<Long> productCodes; // 상품코드
  private List<String> optionValues; // 옵션값
  private List<String> optionValues2; // 옵션값
  private List<Integer> productMoneys; // 상품가격
  private List<Integer> prices; // 가격
  private List<Integer> salePrices; // 세일
  private List<Integer> savedMoneys;
  private List<Integer> quantities; // 수량들
  private List<OrderItem> orderItems; // 개별 주문 항목 리스트

  private List<Integer> priceForeachs;

  private List<String> optionsList; // 옵션리스트


}
