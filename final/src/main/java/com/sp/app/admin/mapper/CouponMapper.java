package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Coupon;

@Mapper
public interface CouponMapper  {
	public void insertCoupon(Coupon dto) throws SQLException;
	public List<Coupon> getListOfCoupon();
	public List<Coupon> getValidCoupons();
}
