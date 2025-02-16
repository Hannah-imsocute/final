package com.sp.app.admin.service;

import com.sp.app.admin.model.Event;

public interface EventManageService {
	
	public String saveCouponName();
	public void insertEvent(Event dto) throws Exception;
}
