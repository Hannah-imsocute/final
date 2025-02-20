package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Event;

public interface EventManageService {
	
	public String saveCouponName();
	public void insertEvent(Event dto) throws Exception;
	
	public int dataCountValidEvent();
	public List<Event> getListOFValidEvent(Map<String, Object> map);
}
