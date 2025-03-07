package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.EventType;
import com.sp.app.admin.model.Winners;
import com.sp.app.admin.service.EventManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;

import jakarta.annotation.PostConstruct;
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
	private final PaginateUtil util;
	private String uploadPath;
	
	
	@PostConstruct
	public void init() {
		uploadPath = this.storage.getRealPath("/uploads/event");
	}
	
	@GetMapping("main")
	public String handleMain(@RequestParam(name = "page", defaultValue = "1")int page, Model model) {
		try {
			List<Event> list = handleRendering(page, "ongoingEvent");
			
			model.addAttribute("list", list);
			
		} catch (Exception e) {
			log.info("==========================handleMain : ", e);
		}
		return "admin/eventList/event";
	}
	
	
	
	@GetMapping("write")
	public String handleWriteForm() {
		return "admin/eventList/eventwrite";
	}
	
	@PostMapping("write")
	public String handleSubmitWriteForm(@ModelAttribute Event dto, @RequestParam("file") MultipartFile file, HttpSession session) {
		
		// session 에 value 로 coupon 또는 스케줄러 정보 저장 있을지는 모름 
		// insert 두번에 걸쳐서 하나의 트랜잭션으로 묶어야함 
		try {
			
			EventType event = (EventType)session.getAttribute("value");
			
			if(event == null) {
				return "redirect:/admin/event/main";
			}
			session.removeAttribute("value");
			
			dto.setEvent(event);
			System.out.println("============================");
			System.out.println("============================");
			System.out.println(file.getOriginalFilename());
			System.out.println("============================");
			System.out.println("============================");
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
	
	
	public List<Event> handleRendering(int page, String mode ){
		List<Event> list = null;
		
		int size = 10;
		int total = 0;
		int datacount = 0;
		
		try {
			
			if(mode.equals("ongoingEvent")) {
				datacount = service.dataCountValidEvent();
			}else if (mode.equals("closedEvent")) {
				datacount = service.dataCountClosedEvent();
			}else if (mode.equals("couponsetting")) {
				datacount = service.dataCountOfCoupon();
			}
			
			total = util.pageCount(datacount, size);
			page = Math.min(page, total);
			
			int offset = (page -1) * size;
			if (offset < 0) offset = 0;
			
			Map<String, Object> map = new HashMap<>();
		
			map.put("offset", offset);
			map.put("size", size);
			
			if(mode.equals("ongoingEvent")) {
				list = service.getListOFValidEvent(map);
			}else if (mode.equals("closedEvent")) {
				list = service.getListOfClosedEvent(map);
			}else if (mode.equals("winners")) {
				list = service.getListOfCoupon(map);
			}
		} catch (Exception e) {
			log.info("===========handleRendering : ", e);
		}
		
		return list;
	}
	
	
	@GetMapping("rendering")
	@ResponseBody
	public Map<String, Object> rendering(@RequestParam(name = "mode")String mode, @RequestParam(name = "page") int page){
		Map<String, Object> map = new HashMap<>();
		
		try {
			List<Event> list =  handleRendering(page, mode);
			
			map.put("list", list);
			map.put("mode", mode);
			
		} catch (Exception e) {
			log.info("=====================rendering", e);
		}
		return map;
	}

	@GetMapping("article/{num}")
	public String getIntoArticle(@PathVariable(name = "num")long num, @RequestParam(name = "type")String type, Model model) {
		try {
			Event dto = service.findByIdOfEvent(num, type);
			
			model.addAttribute("dto", dto);
			model.addAttribute("type", type);
		} catch (Exception e) {
			log.info("===========getIntoArticle");
		}
		return "admin/eventList/article";
	}
	
	@GetMapping("winners")
	public String handlePopup(@RequestParam(name = "num")long num, Model model) {
		try {
			Event dto = service.findByIdOfEvent(num, "comment");
			
			model.addAttribute("dto", dto);
			
		} catch (Exception e) {
			log.info("====================handlePopup : ",e);
		}
		return "admin/eventList/winnerForm";
	}
	
	@GetMapping("getwinners")
	@ResponseBody
	public Map<String, Object> getWinners(@RequestParam(name = "num")long num, @RequestParam(name = "size") int size){
		Map<String, Object> map = new HashMap<>();
		try {
			map.put("num", num);
			map.put("size", size);
			
			service.insertWinners(map);
			
			List<Winners> list = service.getWinners(num);
			
			map.put("list", list);
			map.put("state", "true");
		} catch (Exception e) {
			log.info("===============getWinners:", e);
		}
		
		return map;
	}
}
