package com.sp.app.admin.service;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.EventManageMapper;
import com.sp.app.admin.model.Event;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventManageServiceImpl implements EventManageService {
	
	private final EventManageMapper mapper;
	
	@Override
	public String saveCouponName() {
			long millis = System.currentTimeMillis();

			String millisecond = String.valueOf(millis);

			String letters = "abcdefghijklmopqrstuwxyz";

			SecureRandom random = new SecureRandom();

			StringBuilder sb = new StringBuilder();

			for (int i = 0; i <= 5; i++) {
				sb.append(letters.charAt(random.nextInt(letters.length())));
			}
			sb.append(millisecond);
			
			return sb.toString();
	}

	@Transactional
	@Override
	public void insertEvent(Event dto) throws Exception {
		try {
			
			mapper.insertEvent(dto);
			
			if(! dto.getEventType().equalsIgnoreCase("comment")) {
				mapper.insertEventType(dto.getEvent());
			}
			
		} catch (Exception e) {
			log.info("=============insertEvent", e);
		}
	}

	@Override
	public int dataCountValidEvent() {
		return mapper.dataCountValidEvent();
	}

	@Override
	public List<Event> getListOFValidEvent(Map<String, Object> map) {
		List<Event> list = null;
		try {
			list = mapper.getListOFValidEvent(map);
		} catch (Exception e) {
			log.info("================getListOFValidEvent", e);
		}
		return list;
	}

	@Override
	public Event findByIdOfEvent(long num, String Type) {
		Event dto = null;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("num", num);
			map.put("type", Type);
			dto = mapper.findByIdOfEvent(map);
		} catch (Exception e) {
			log.info("===============findByIdOfEvent: ", e);
		}
		return dto;
	}

	
	
}
