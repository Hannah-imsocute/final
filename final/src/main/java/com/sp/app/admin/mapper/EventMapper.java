package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ClockinEvent;
import com.sp.app.admin.model.Coupon;

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
}
