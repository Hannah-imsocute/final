package com.sp.app.admin.service;

import java.util.List;

import com.sp.app.admin.model.Coupon;

public interface AdminCouponService {
	public void insertCoupon(Coupon dto) throws Exception;
	public List<Coupon> getListOfCoupon();
}
