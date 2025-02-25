package com.sp.app.admin.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Report {
	
	// 작품신고 
	private long sellerreport_num;
	private long productcode;
	private String reason;
	private String processdate;
	private String releasedate;
	
	// 공용 
	private String report_date;
	private long memberidx;
	private String name;
	
	// 후기 카테고리
	private String category_name;
	private long category_num;
	
	// 후기 신고 
	private long report_code;
	private long review_num;
	private String content;
}
