 package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;
import com.sp.app.model.EventComment;
import com.sp.app.model.MemberPoint;

@Mapper
public interface EventMapper {
	public List<Event> eventList();
	public Event findById(Map<String, Object> map);
	public List<String> checkedDate(Map<String, Object> map);
	
	public void insertCheckin(Map<String, Object> map) throws SQLException;
	public void insertPoints(MemberPoint memberpoint) throws SQLException;
	public void insertGetCoupon(Map<String, Object> map)throws SQLException;
	
	public String hasCoupon(Map<String, Object> map);
	public EventType couponInfo(String coupon_code);

	public void insertComment(Map<String, Object> map) throws SQLException;
	public List<EventComment> commList(long evtnum);
	public void deleteComm(long evtcmm_num) throws SQLException;
}
