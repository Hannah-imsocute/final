package com.sp.app.admin.service;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import com.sp.app.admin.model.ClockinEvent;
import com.sp.app.admin.model.Coupon;

public interface AdminCouponService {
	public void insertCoupon(Coupon dto) throws Exception;
	public List<Coupon> getListOfCoupon();
	public List<Coupon> getValidCoupons();
	

	public void insertClockEvent(ClockinEvent dto) throws SQLException;
	public ClockinEvent current_event(Date today);
	public List<ClockinEvent> listOfClockin();
	public List<ClockinEvent> getValidClockin();
}
