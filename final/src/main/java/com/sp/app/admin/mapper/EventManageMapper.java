package com.sp.app.admin.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;

@Mapper
public interface EventManageMapper {

	public void insertEvent(Event dto) throws SQLException;
	public void insertEventType(EventType dto) throws SQLException;
}
