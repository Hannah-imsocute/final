package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.admin.model.ClockinEvent;
import com.sp.app.admin.model.Coupon;

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
}
