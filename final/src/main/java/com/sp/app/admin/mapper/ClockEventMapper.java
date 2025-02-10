package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.Date;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ClockinEvent;

@Mapper
public interface ClockEventMapper {
	public void insertClockEvent(ClockinEvent dto) throws SQLException;
	public ClockinEvent current_event(Date today);
}
