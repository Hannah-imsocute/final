package com.sp.app.controller;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.Event;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.EventService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/event/*")
@RequiredArgsConstructor
public class EventController {
	
	private final EventService service;
	
	@GetMapping("main")
	public String handleMain(@RequestParam(name = "page", defaultValue = "1") String page, Model model) {
		
		// 페이징 처리 해야됨 
		try {
			
			List<Event> list = service.eventList();
			
			model.addAttribute("list", list);
			
		} catch (Exception e) {
			
		}
		
		return "event/main";
	}
	
	@GetMapping("article/{Type}/{articleNumber}")
	public String handleArticle(@PathVariable(name = "articleNumber") long articleNumber, @PathVariable(name = "Type") String Type, Model model, HttpSession session) {
		
		// Type 이 clockin 일때 comment 일때 coupon 일때 화면이 다다름 
		Map<String, Object> map = new HashMap<>();
		map.put("type", Type);
		map.put("eventNum", articleNumber);
		Event dto = null;
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			if(Type.equalsIgnoreCase("coupon")) {
				
				dto = service.findById(map);
				
				// 해당쿠폰을 이미 발급받았는지 여부 
				map.put("coupon_code", dto.getEvent().getCoupon_code());
				map.put("memberidx", info.getMemberIdx());
				
				String valid = service.hasCoupon(map);
				
				model.addAttribute("valid", valid);
				model.addAttribute("dto", dto);
				return "event/couponArticle";

			}else if(Type.equalsIgnoreCase("clockin") || Type.equalsIgnoreCase("checkin")) {
				dto = service.findById(map);
				
				List<String> checkedDate = service.selectChecked(dto.getEvent_article_num(), info.getMemberIdx());
				
				
				String year = dto.getStartdate().substring(0,3);
				String month = dto.getStartdate().substring(4,5);
				
				LocalDate ld = LocalDate.of(Integer.parseInt(year),Integer.parseInt(month)+1, 1);
				
				// 1 월  ~ 7 일  
				int dayofweek = ld.getDayOfWeek().getValue();
				int lastday = YearMonth.of(Integer.parseInt(year), Integer.parseInt(month)).lengthOfMonth();
				
				model.addAttribute("dayofweek", dayofweek);
				model.addAttribute("lastday", lastday);
				model.addAttribute("checkedDate", checkedDate);
				model.addAttribute("year", year);
				model.addAttribute("month", month);
				model.addAttribute("dto", dto);
				return "event/clockinArticle";

			}else {
				dto = service.findById(map);
				model.addAttribute("dto", dto);
				return "event/commentArticle";
			}
		} catch (Exception e) {
			
		}
		return "redirect:/event/main";
	}
	
	
	@PostMapping("checked")
	@ResponseBody
	public Map<String, Object> checkedInsert(@RequestBody Map<String, Object> params, HttpSession session){
		Map<String, Object> map = new HashMap<>();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			params.put("memberidx", info.getMemberIdx());
			service.insertCheckin(params);
			
			map.put("state", "true");
		} catch (Exception e) {
		}
		return map;
	}
	
	
	@PostMapping("getCoupon")
	@ResponseBody
	public Map<String, Object> getCoupon(@RequestBody Map<String, Object> params, HttpSession session){
		Map<String, Object> map = new HashMap<>();
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		
		try {
			params.put("memberidx", info.getMemberIdx());
			System.out.println("=========================");
			System.out.println("=========================");
			System.out.println(params.get("couponcode"));
			System.out.println(params.get("eventNum"));
			System.out.println("=========================");
			System.out.println("=========================");
			System.out.println("=========================");
			
			service.insertGetCoupon(params);
			map.put("state", "true");
		} catch (Exception e) {
		}
		
		return map;
	}
}
