package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.model.Event;
import com.sp.app.mapper.EventMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class EventServiceImpl implements EventService {
	
	private final EventMapper mapper;
	
	@Override
	public List<Event> eventList() {
		List<Event> list = null;
		try {
			list = mapper.eventList();
		} catch (Exception e) {
			log.info("=============eventList",e);
		}
		return list;
	}

	@Override
	public Event findById(Map<String, Object> map) {
		Event dto = null;
		try {
			dto = mapper.findById(map);
		} catch (Exception e) {
			log.info("=================findById", e);
		}
		return dto;
	}
	
	
}
