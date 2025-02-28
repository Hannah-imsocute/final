package com.sp.app.artist.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class OrderDetailManage {
	private long productNum;
	private String item;
	private int optionCount;
	private int price;
    private int discountRate;
    private int delivery;
    private int cancelAmount;
    private long memberIdx;
    private String userId;
    private String nickName;
    
    private String item_code;
	private String order_code;
    private long orderDetailNum;
	private String order_Date;
	private int usedSaved;
    private int payment;
    private int totalMoney;
    private int deliveryCharge;
    private int salePrice;
	private int totalQty;
	private int productMoney;
	private int savedMoney;
	private String orderStateDate;
	private int orderPrice;
	
	private long detailNum;
	private String options;
	private Long detailNum2;
	private String optionValue2;
	
	private int orderState;
	private String orderStateInfo;
	private int detailState;
	private String detailStateInfo;
	private String stateMemo;
	private String stateDate;
	private String stateProduct;
	private int spentPoint;
	private String company_name; // 택배사
	private String invoiceNumber; // 송장번호
}
