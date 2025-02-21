package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;
import com.sp.app.admin.model.Winners;

@Mapper
public interface EventManageMapper {
	
	// event게시글과 event 상세 쿠폰및 출첵이벤트 등록
	public void insertEvent(Event dto) throws SQLException;
	public void insertEventType(EventType dto) throws SQLException;
	
	// event 게시글 유효한것만 카운트
	public int dataCountValidEvent();
	
	
	// 유효한 게시글만 리스트 뽑기
	public List<Event> getListOFValidEvent(Map<String, Object> map);
	
	// findbyid 이벤트 게시글
	public Event findByIdOfEvent(Map<String, Object> map);
	
	
	// 댓글이벤트에대한 당첨자 발표 
	public List<Winners> getWinners(long num);
	
	// 당첨자 insert 
	public void insertWinners(Map<String, Object> map) throws SQLException;
	
	
}
