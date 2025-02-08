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

import com.sp.app.admin.service.AdminCouponService;
import com.sp.app.model.Coupon;

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

	@GetMapping("/report")
	public String reportMain() {
		return "admin/report";
	}
	
}
