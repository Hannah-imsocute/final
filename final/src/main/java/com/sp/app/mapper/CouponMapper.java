package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Coupon;

@Mapper
public interface CouponMapper  {
	public void insertCoupon(Coupon dto) throws SQLException;
	public List<Coupon> getListOfCoupon();
}
