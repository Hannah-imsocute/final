package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.Event;
import com.sp.app.service.EventService;

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
	public String handleArticle(@PathVariable(name = "articleNumber") long articleNumber, @PathVariable(name = "Type") String Type, Model model) {
		
		// Type 이 clockin 일때 comment 일때 coupon 일때 화면이 다다름 
		Map<String, Object> map = new HashMap<>();
		map.put("type", Type);
		map.put("eventNum", articleNumber);
		Event dto = null;
		try {
			if(Type.equalsIgnoreCase("coupon")) {
				dto = service.findById(map);
				model.addAttribute("dto", dto);
				return "event/couponArticle";

			}else if(Type.equalsIgnoreCase("clockin")) {
				dto = service.findById(map);
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
}
