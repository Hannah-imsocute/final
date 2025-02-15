package com.sp.app.admin.service;

import java.sql.SQLException;

import com.sp.app.admin.model.Event;

public interface EventManageService {
	
	public String saveCouponName();
	public void insertEvent(Event dto, Event value) throws Exception;
}
