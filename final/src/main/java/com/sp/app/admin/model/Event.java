
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
	
	private EventType event;
}
