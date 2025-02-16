package com.sp.app.admin.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class EventType {
	
	private String eventType;
	
	private String coupon_code;
	private String couponname;
	private int valid;
	private int rate;
	private String couponstart;
	private String expiredate;
	
	private long clickin_num;
	private int daybyday;
	private int weekly;
	private int monthly;
}
