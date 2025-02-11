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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Coupon> getAllCoupon() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertClockin(ClockinEvent dto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ClockinEvent> getValidClockin() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ClockinEvent> getAllClockin() {
		// TODO Auto-generated method stub
		return null;
	}

}
