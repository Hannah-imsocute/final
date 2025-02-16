package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;
import com.sp.app.admin.service.EventManageService;
import com.sp.app.common.StorageService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/event/*")
@RequiredArgsConstructor
@Slf4j
public class AdminEventController {
	
	private final EventManageService service;
	private final StorageService storage;
	private final String uploadPath = "/uploads/event";
	
	
	@GetMapping("main")
	public String handleMain() {
		return "admin/eventList/event";
	}
	
	@GetMapping("write")
	public String handleWriteForm() {
		return "admin/eventList/eventwrite";
	}
	
	@PostMapping("write")
	public String handleSubmitWriteForm(@ModelAttribute Event dto,@RequestParam("thumbnail") MultipartFile file, HttpSession session) {
		
		// session 에 value 로 coupon 또는 스케줄러 정보 저장 있을지는 모름 
		// insert 두번에 걸쳐서 하나의 트랜잭션으로 묶어야함 
		
		try {
			
			EventType event = (EventType)session.getAttribute("value");
			
			if(event == null) {
				return "redirect:/admin/event/main";
			}
			session.removeAttribute("value");
			
			dto.setEvent(event);
			
			String filename = storage.uploadFileToServer(file, uploadPath);
			
			dto.setThumbnail(filename);
			
			service.insertEvent(dto);
			
		} catch (Exception e) {
			log.info("=================controller  handleSubmitWriteForm", e);
		}
		
		return "redirect:/admin/event/main";
	}
	
	@GetMapping("bringform")
	public String ajaxinputForm(@RequestParam(name = "type") String type) {
		return type.equalsIgnoreCase("coupon") ? "admin/eventList/couponform" : "admin/eventList/checkinform";
	}
	
	
	
	@PostMapping("typefixed")
	@ResponseBody
	public Map<String, Object> ajaxTypefixed(@ModelAttribute EventType dto, HttpSession session){
		Map<String, Object> map = new HashMap<>();
		
		try {
			if(dto.getEventType().equals("coupon")) {
				dto.setCoupon_code(service.saveCouponName());
				session.setAttribute("value", dto);
			}else if(dto.getEventType().equals("checkin")) {
				session.setAttribute("value", dto);
			}
			map.put("dto", dto);
			map.put("state", "success");
			
		} catch (Exception e) {
			log.info("============controller ajaxTypefixed", e);
		}
		
		return map;
	}
}
