package com.sp.app.artist.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class OrderProduct {
    private String item_code;
    private long productCode;
    private String item;
    private int options;
    private int price;
    private int discountRate;
    private int delivery;
    private int cancelAmount;
    private String nickName;
    private String userName;
    private String orderNum;
    private long orderDetailNum;
    private String orderDate;
    private int usedSaved;
    private int payment;
    private int totalMoney;
    private int deliveryCharge;
    private int salePrice;
    private int qty;
    private int productMoney;
    private int savedMoney;

    private long detailNum;
    private String optionValue;

    private int orderState;
    private String orderStateInfo;
    private int detailState;
    private String detailStateInfo;
    private String stateMemo;
    private String stateDate;
    private String stateProduct;

    private String deliveryName; // 택배사
    private String invoiceNumber; // 송장번호
}
