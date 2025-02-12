package com.sp.app.admin.service;

import java.security.SecureRandom;
import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.EventMapper;
import com.sp.app.admin.model.ClockinEvent;
import com.sp.app.admin.model.Coupon;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class EventServiceImpl implements EventService {

	private final EventMapper eventMapper;

	@Override
	public void insertCoupon(Coupon dto) throws Exception {

		try {

			long millis = System.currentTimeMillis();

			String millisecond = String.valueOf(millis);

			String letters = "abcdefghijklmopqrstuwxyz";

			SecureRandom random = new SecureRandom();

			StringBuilder sb = new StringBuilder();

			for (int i = 0; i <= 5; i++) {
				sb.append(letters.charAt(random.nextInt(letters.length())));
			}
			sb.append(millisecond);

			dto.setCoupon_code(sb.toString());
			
			eventMapper.insertCoupon(dto);
			
		} catch (Exception e) {
			log.info("========================insertCoupon :", e);
			throw e;
		}

	}

	@Override
	public List<Coupon> getValidCoupon() {
		List<Coupon> list = null;
		try {
			list = eventMapper.getValidCoupon();
		} catch (Exception e) {
			log.info("===================getValidCoupon", e);
		}
		return list;
	}

	@Override
	public List<Coupon> getAllCoupon() {
		List<Coupon> list = null;
		try {
			list = eventMapper.getAllCoupon();
		} catch (Exception e) {
			log.info("===================getAllCoupon", e);
		}
		return list;
	}

	@Override
	public void insertClockin(ClockinEvent dto) throws Exception {
		try {
			eventMapper.insertClockin(dto);
		} catch (Exception e) {
			log.info("========================insertClockin : ", e);
			throw e;
		}
	}

	@Override
	public List<ClockinEvent> getValidClockin() {
		List<ClockinEvent> list = null;
		try {
			list = eventMapper.getValidClockin();
		} catch (Exception e) {
			log.info("===================getValidClockin", e);
		}
		return list;
	}

	@Override
	public List<ClockinEvent> getAllClockin() {
		List<ClockinEvent> list = null;
		try {
			list = eventMapper.getAllClockin();
		} catch (Exception e) {
			log.info("===================getAllClockin", e);
		}
		return list;
	}

}
