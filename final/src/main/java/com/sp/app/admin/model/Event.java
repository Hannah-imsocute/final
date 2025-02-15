package com.sp.app.admin.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Event {
	private long event_article_num;
	
	private String subject;
	private String textcontent;
	private String eventType;
	private String thumbnail;
	private String startdate;
	private String enddate;
	private String created;
	
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
