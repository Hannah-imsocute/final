package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Event;

public interface EventService {
	public List<Event> eventList();
	public Event findById(Map<String, Object> map);

}
