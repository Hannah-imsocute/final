package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class SettlementManage {
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
}
