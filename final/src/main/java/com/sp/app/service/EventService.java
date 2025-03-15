package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;
import com.sp.app.model.EventComment;

public interface EventService {
	public List<Event> eventList();
	public Event findById(Map<String, Object> map);
	
	public List<String> selectChecked(long num, long memberidx);
	public void insertCheckin(Map<String, Object> map) throws Exception;
	public void insertGetCoupon(Map<String, Object> map)throws SQLException;
	
	public String hasCoupon(Map<String, Object> map);
	public EventType couponInfo(String coupon_code);
	
	public void insertComment(Map<String, Object> map) throws Exception;
	public List<EventComment> commList(long evtnum);
	public void deleteComm(long evtcmm_num) throws Exception;
}
