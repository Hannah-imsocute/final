package com.sp.app.admin.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	private long evt_not_num;
	private String nickname;
	private long adminidx;
	private String subject;
	private String textcontent;
	private int fixed;
	private String create_date;
	private long category_num;
	private String category_name;
}
