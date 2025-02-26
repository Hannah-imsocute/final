package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SettlementManage {
	// 상세보기 누르면 정산 상품에 관한 dto
	private String item_code;
	private String order_code;
	private String productCode;
	private String options;
	private String priceOrEach;
	private String quantity;
	private String price;
	private String shipping;
	private String order_State;
	private String orderStateDate;
	
	// 정산에 관련된 dto
	private String settlement_num;
	private String brand_code;
	private String brandname;
	private String nickname;
	private String point_amount;
	private String settlement_date;
	private String deposit;
	private String pointbalance;
	private String state;
	
	// 현금 정산 관련 dto
	private String withdraw_num;
	private String point_amount2;
	private String surcharge;
	private String withdraw_date;
	private String state2;
	
	
}
