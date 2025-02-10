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
	
	private final long clockin_num;
	private final String event_title;
	private final String start_date;
	private final String expire_date;
	private final int daybyday;
	private final int weekly;
	private final int monthly;
	
}
