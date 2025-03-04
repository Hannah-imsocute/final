package com.sp.app.controller;

import java.time.LocalDate;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.reflection.SystemMetaObject;
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
				
				List<String> chkdates = new ArrayList<>();
				List<String> checkedDate = service.selectChecked(dto.getEvent_article_num(), info.getMemberIdx());
				
				if(checkedDate.size() != 0 ) {
					for(String date : checkedDate) {
						String realday = date.substring(date.lastIndexOf("-")+1);
						if(realday.startsWith("0")) {
							chkdates.add(date.substring(date.lastIndexOf("-")+2));
						}else {
							chkdates.add(realday);
						}
					}
					Collections.sort(chkdates, Comparator.comparingInt(Integer::parseInt));
				}
				
				// 오늘 날짜
				Calendar cal = Calendar.getInstance();
				int ty = cal.get(Calendar.YEAR);
				int tm = cal.get(Calendar.MONTH)+1;
				int td = cal.get(Calendar.DATE);
				// 이벤트 달력 
				int ey = Integer.parseInt(dto.getStartdate().substring(0, 4));
				int em;
				if(dto.getStartdate().substring(6,8).indexOf("-") != -1) {
					em = Integer.parseInt(dto.getStartdate().substring(6,7));
				}else {
					em = Integer.parseInt(dto.getStartdate().substring(6, 8));
				}
				
				// 이벤트 달 기준1일
				cal.set(ey, em-1, 1);
				
				int year = cal.get(Calendar.YEAR);
				int month = cal.get(Calendar.MONTH)+1;
				
				// 마지막 날
				int lastdate =cal.getActualMaximum(Calendar.DATE);
				
				// 1일 기준 요일  일 1 - 토 7
				int week = cal.get(Calendar.DAY_OF_WEEK);
				
				
				model.addAttribute("checked", chkdates);
				model.addAttribute("ty", ty);
				model.addAttribute("tm", tm);
				model.addAttribute("td", td);
				model.addAttribute("year", year);
				model.addAttribute("month", month);
				model.addAttribute("lastDate", lastdate);
				model.addAttribute("week", week);
				model.addAttribute("dto", dto);
				
				return "event/clockinArticle";

			}else {
				dto = service.findById(map);
				model.addAttribute("dto", dto);
				return "event/commentArticle";
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return "redirect:/event/main";
	}
	
	
	@PostMapping("checked")
	@ResponseBody
	public Map<String, Object> checkedInsert(@RequestParam Map<String, Object> params, HttpSession session){
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
			
			service.insertGetCoupon(params);
			map.put("state", "true");
		} catch (Exception e) {
		}
		
		return map;
	}
}
