package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Event;

@Mapper
public interface EventMapper {
	public List<Event> eventList();
	public Event findById(Map<String, Object> map);
}
