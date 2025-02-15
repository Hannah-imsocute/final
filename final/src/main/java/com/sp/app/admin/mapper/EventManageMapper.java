package com.sp.app.admin.mapper;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Event;

@Mapper
public interface EventManageMapper {

	public void insertEvent(Event dto) throws SQLException;
}
