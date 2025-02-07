package com.sp.app.service;

import java.security.SecureRandom;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.CouponMapper;
import com.sp.app.model.Coupon;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminCouponServiceImpl implements AdminCouponService{
	
	private final CouponMapper mapper;

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
			
			mapper.insertCoupon(dto);
			
		} catch (Exception e) {
			log.info("=========insertCoupon : ", e);
			throw e;
		}
	}

	@Override
	public List<Coupon> getListOfCoupon() {
		List<Coupon> list = null;
		try {
			list = mapper.getListOfCoupon();
		} catch (Exception e) {
			log.info("===========getListOfCoupon : ", e);
		}
		return list;
	}
	
}
