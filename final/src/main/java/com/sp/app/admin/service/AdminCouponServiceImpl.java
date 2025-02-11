package com.sp.app.admin.service;

import java.security.SecureRandom;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.ClockEventMapper;
import com.sp.app.admin.mapper.CouponMapper;
import com.sp.app.admin.model.ClockinEvent;
import com.sp.app.admin.model.Coupon;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminCouponServiceImpl implements AdminCouponService{
	
	private final CouponMapper couponMapper;
	private final ClockEventMapper clockeventMapper;

	@Override
	public void insertCoupon(Coupon dto) throws Exception {
		try {
			
			long millis = System.currentTimeMillis();
			
			String millisecond = String.valueOf(millis);
			
			String letters = "abcdefghijklmopqrstuwxyz";
			
			SecureRandom random = new SecureRandom();
			
			StringBuilder sb = new StringBuilder();
			
			for(int i = 0; i <= 5; i++) {
				sb.append(letters.charAt(random.nextInt(letters.length())));
			}
			sb.append(millisecond);
			
			dto.setCoupon_code(sb.toString());
			
			couponMapper.insertCoupon(dto);
			
		} catch (Exception e) {
			log.info("=========insertCoupon : ", e);
			throw e;
		}
	}

	@Override
	public List<Coupon> getListOfCoupon() {
		List<Coupon> list = null;
		try {
			list = couponMapper.getListOfCoupon();
		} catch (Exception e) {
			log.info("===========getListOfCoupon : ", e);
		}
		return list;
	}

	@Override
	public void insertClockEvent(ClockinEvent dto) throws SQLException {
		try {
			clockeventMapper.insertClockEvent(dto);
		} catch (Exception e) {
			log.info("========================insertClockEvent : ", e);
			throw e; 
		}
	}

	@Override
	public ClockinEvent current_event(Date today) {
		ClockinEvent dto = null;
		try {
			dto = clockeventMapper.current_event(today);
		} catch (Exception e) {

		}
		return dto;
	}
	
	
	
}
