package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;
import com.sp.app.admin.model.Winners;

public interface EventManageService {
	
	public String saveCouponName();
	public void insertEvent(Event dto) throws Exception;
	
	
	// 진행중인 이벤트
	public int dataCountValidEvent();
	public List<Event> getListOFValidEvent(Map<String, Object> map);
	
	// 종료된 이벤트
	public int dataCountClosedEvent();
	public List<Event> getListOfClosedEvent(Map<String, Object> map);
	
	// 쿠폰 관리 
	public int dataCountOfCoupon();
	public List<Event> getListOfCoupon(Map<String, Object> map);
	
	
	
	public Event findByIdOfEvent(long num, String Type);
	
	// 댓글이벤트에대한 당첨자 발표 
	public List<Winners> getWinners(long num);
	
	public void insertWinners(Map<String, Object> map) throws SQLException;
}
