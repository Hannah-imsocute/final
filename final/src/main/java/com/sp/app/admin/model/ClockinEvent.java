package com.sp.app.admin.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@Builder
public class ClockinEvent {
	
	private  long clockin_num;
	private  String event_title;
	private  String start_date;
	private  String expire_date;
	private  int daybyday;
	private  int weekly;
	private  int monthly;
	private  int selected;
}
