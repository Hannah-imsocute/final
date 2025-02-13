package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ClockinEvent;
import com.sp.app.admin.model.Coupon;
import com.sp.app.admin.model.Event;

public interface EventService {
	
	// 쿠폰등록
	public void insertCoupon(Coupon dto) throws Exception;
	
	// 게시글에 등재되지않은 쿠폰만
	public List<Coupon> getValidCoupon();
	
	// 등록되어있는 모든 쿠폰
	public List<Coupon> getAllCoupon();
	
	// 출첵이벤트 등록
	public void insertClockin(ClockinEvent dto) throws Exception;
	
	// 게시글에 등재되지 않은 출첵이벤트만
	public List<ClockinEvent> getValidClockin();
	
	// 등록되어있는 모든 출첵 이벤트
	public List<ClockinEvent> getAllClockin();
	
	// 이벤트 글등록
	public void insertEvent(Event dto) throws Exception;
	
	// 데이터 개수 
	public int dataCount();
	
	// 게시글 가져오깅
	public List<Event> getEventList(Map<String, Object> map);
	
}
