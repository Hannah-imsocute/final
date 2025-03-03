package com.sp.app.admin.service;

import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.EventManageMapper;
import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;
import com.sp.app.admin.model.Winners;
import com.sp.app.common.MyUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventManageServiceImpl implements EventManageService {
	
	private final EventManageMapper mapper;
	private final MyUtil util;
	
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
			
			dto.setThumbnail(dto.getThumbnail());
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

	@Override
	public List<Winners> getWinners(long num) {
		List<Winners> list = null;
		try { 
			list = mapper.getWinners(num);
			
			for(Winners dto : list) {
				dto.setNickname(util.nameMasking(dto.getNickname()));
				dto.setEmail(util.emailMasking(dto.getEmail()));
			}
			
		} catch (Exception e) {
			log.info("==============getwinners : ", e);
		}
		return list;
	}

	@Override
	public void insertWinners(Map<String, Object> map) throws SQLException {
		try {
			mapper.insertWinners(map);
		} catch (Exception e) {
			log.info("=====================insertWinners : ", e);
		}
	}

	@Override
	public int dataCountClosedEvent() {
		int result = 0;
		try {
			result = mapper.dataCountClosedEvent();
		} catch (Exception e) {
			log.info("==============dataCountClosedEvent : ", e);
		}
		return result;
	}

	@Override
	public List<Event> getListOfClosedEvent(Map<String, Object> map) {
		List<Event> list = null;
		try {
			list = mapper.getListOfClosedEvent(map);
		} catch (Exception e) {
			log.info("===================getLIstOFClosedEvent", e);
		}
		return list;
	}

	@Override
	public int dataCountOfCoupon() {
		int result = 0;
		try {
			result = mapper.dataCountOfCoupon();
		} catch (Exception e) {
			log.info("==============dataCountOfCoupon : ", e);
		}
		return result;
	}

	@Override
	public List<Event> getListOfCoupon(Map<String, Object> map) {
		List<Event> list = null;
		try {
			list = mapper.getListOfCoupon(map);
		} catch (Exception e) {
			log.info("===================getLIstOFClosedEvent", e);
		}
		return list;
	}

}
