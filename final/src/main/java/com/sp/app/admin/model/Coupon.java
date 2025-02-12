package com.sp.app.admin.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Coupon {
	private String coupon_code;
	private String couponName;
	private int rate;
	private String start;
	private String end;
	private int valid;
	private int selected;
}
