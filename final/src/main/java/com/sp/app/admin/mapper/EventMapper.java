package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ClockinEvent;
import com.sp.app.admin.model.Coupon;
import com.sp.app.admin.model.Event;

@Mapper
public interface EventMapper {
	
	// 쿠폰등록
	public void insertCoupon(Coupon dto) throws SQLException;
	
	// 게시글에 등재되지않은 쿠폰만
	public List<Coupon> getValidCoupon();
	
	// 등록되어있는 모든 쿠폰
	public List<Coupon> getAllCoupon();
	
	// 출첵이벤트 등록
	public void insertClockin(ClockinEvent dto) throws SQLException;
	
	// 게시글에 등재되지 않은 출첵이벤트만
	public List<ClockinEvent> getValidClockin();
	
	// 등록되어있는 모든 출첵 이벤트
	public List<ClockinEvent> getAllClockin();
	
	
	// 이벤트 글등록
	public void insertEvent(Event dto) throws SQLException;
	
	// 데이터 개수 
	public int dataCount();
	
	// 게시글 가져오깅
	public List<Event> getEventList(Map<String, Object> map);

}
