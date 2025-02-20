package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;

@Mapper
public interface EventManageMapper {

	public void insertEvent(Event dto) throws SQLException;
	public void insertEventType(EventType dto) throws SQLException;
	
	public int dataCountValidEvent();
	
	public List<Event> getListOFValidEvent(Map<String, Object> map);
}
