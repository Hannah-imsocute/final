package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.ClockinEvent;
import com.sp.app.admin.model.Coupon;
import com.sp.app.admin.service.AdminCouponService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/adminevent/")
@RequiredArgsConstructor
@Slf4j
public class AdminEventController {
	
	private final AdminCouponService service;
	
	@GetMapping("/main")
	public String eventMain(Model model) {
		try {
			List<Coupon> list = service.getListOfCoupon();
			
			model.addAttribute("couponlist", list);
		} catch (Exception e) {

		}
		return "admin/event";
	}

	@PostMapping("/coupon")
	@ResponseBody
	public Map<String, Object> couponupload(
			@RequestParam(value =  "name") String name, 
			@RequestParam(value =  "rate") int rate,
			@RequestParam(value =  "start") String start,
			@RequestParam(value =  "end") String end,
			@RequestParam(value =  "valid") int valid
			) {
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			Coupon coupon = Coupon.builder().couponName(name).rate(rate).start(start).end(end).valid(valid).build();
			
			service.insertCoupon(coupon);
			
		} catch (Exception e) {
			map.put("state", "failed");
		}
		map.put("state", "success");
		
		return map;
	}

	// 출석체크 이벤트는 현재 진행 중인 출첵 이벤트가 있다면 중복으로 겹칠 수 없게 설정
	// 현재 진행중인 출석체크 이벤트만 클라이언트에게 보여줌 
	// 현재 진행중인 출석체크 이벤트를 어떻게 가져오지 // 오늘 날짜를 기준으로 eventstart =< today <= eventend
	@ResponseBody
	@PostMapping("/clockin")
	public Map<String, Object> eventload(
			@RequestParam(value = "eventName") String eventName,
			@RequestParam(value = "daypoint") int daypoint,
			@RequestParam(value = "weeklypoint") int weeklypoint,
			@RequestParam(value = "monthlypoint") int monthlypoint,
			@RequestParam(value = "eventstart") String eventstart,
			@RequestParam(value = "eventend") String eventend
			) {
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			ClockinEvent dto = ClockinEvent.builder()
										.event_title(eventName)
										.daybyday(daypoint)
										.weekly(weeklypoint)
										.monthly(monthlypoint)
										.start_date(eventstart)
										.expire_date(eventend).build();
			service.insertClockEvent(dto);
			
		} catch (Exception e) {
			map.put("state", "failed");
		}
		
		map.put("state", "success");
		
		return map;
	}
	
	
	@GetMapping("/posting")
	public String writeForm() {
		return "admin/eventwrite";
	}
	
	@GetMapping("/report")
	public String reportMain() {
		return "admin/report";
	}
	
}
