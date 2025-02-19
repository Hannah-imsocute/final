package com.sp.app.admin.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Infoapply {

	private long info_num;
	private long memberidx;
	private String subject;
	private String textcontent;
	private String apply_date;

	
	// 답변 관리자  null 허용 
	private long adminidx;
	private int answerstate;
	
	// null 허용
	private String answer_date;

	private long category_num;
}
