package com.sp.app.service;

import java.util.List;

import com.sp.app.model.Coupon;

public interface AdminCouponService {
	public void insertCoupon(Coupon dto) throws Exception;
	public List<Coupon> getListOfCoupon();
}
