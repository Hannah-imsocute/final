package com.sp.app.service;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;
import com.sp.app.mapper.EventMapper;
import com.sp.app.model.MemberPoint;

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
	
	@Override
	public List<String> selectChecked(long num, long memberidx){
		List<String> list = null;
		Map<String, Object> map = new HashMap<>();
		try {
			map.put("num", num);
			map.put("memberIdx", memberidx);
			
			list = mapper.checkedDate(map);
			
		} catch (Exception e) {
			log.info("==============selectChecked");
		}
		return list;
	}

	
	@Override
	public void insertCheckin(Map<String, Object> map) throws Exception {
		try {
			
			// 출석체크 기록
			mapper.insertCheckin(map);
			
			// 포인트 지급 
			// memberidx, saveamount, reason, balance
			// balance 가 문젱데 ? 
			int balance = 0 ;
			MemberPoint mp = new MemberPoint();
			
			// 일간 주간 월간 출석체크가 넣어주는 금액이 다른데 
			// 고민을 해볼 여지가 있다 
			
		} catch (Exception e) {
			log.info("==============insertCheckin", e);
		}
	}

	@Override
	public String hasCoupon(Map<String, Object> map) {
		String result = null;
		try {
			result = mapper.hasCoupon(map);
		} catch (Exception e) {
			log.info("===============hasCoupon : ", e);
		}
		return result;
	}

	@Override
	public void insertGetCoupon(Map<String, Object> map) throws SQLException {
		try {
			// 쿠폰코드, 쿠폰유효기간, 만료일 알아내면 insert 가능 
			String coupon_code = (String)map.get("couponcode");
			EventType dto = couponInfo(coupon_code);
			
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, dto.getValid());
			
			int year = cal.get(Calendar.YEAR);
			int month  = cal.get(Calendar.MONTH);
			int day = cal.get(Calendar.DATE);
			
			StringBuffer sb = new StringBuffer();
			
			sb.append(String.valueOf(year));
			sb.append(String.valueOf(month));
			sb.append(String.valueOf(day));
			
			map.put("expiredate", sb.toString());
			mapper.insertGetCoupon(map);
		} catch (Exception e) {
			log.info("========================insertGetCoupon : ", e);
		}
		
	}

	@Override
	public EventType couponInfo(String coupon_code) {
		EventType dto = null; 
		try {
			dto = mapper.couponInfo(coupon_code);
		} catch (Exception e) {
			log.info("==============couponInfo : ", e);
		}
		return dto;
	}
	
}
