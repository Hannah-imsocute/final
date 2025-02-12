package com.sp.app.admin.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Event {
	private long event_article_num;
	private String subject;
	private String textcontent;
	private String createdDate;
	
	private String eventType;
	private String coupon_code;
	private long clockin_num;
	
	private String thumbnail;
}
