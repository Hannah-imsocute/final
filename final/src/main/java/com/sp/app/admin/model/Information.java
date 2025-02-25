package com.sp.app.admin.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Information {
	private long info_num;
	private long memberidx;
	
	private long adminidx;
	
	private String subject;
	private String textcontent;
	private String apply_date;
	
	private int answerstate;
	private String answer_date;
	
	private long category_num;
	private String category_name;
}
