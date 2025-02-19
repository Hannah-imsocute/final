package com.sp.app.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.Notice;
import com.sp.app.common.PaginateUtil;
import com.sp.app.service.NoticeService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/notice/*")
@RequiredArgsConstructor
public class NoticeController {
	
	private final NoticeService service;
	private final PaginateUtil util;
	
	// faq 띄우는거 
	@GetMapping("main")
	public String getMain(@RequestParam(name = "page", defaultValue = "1")int page,
						@RequestParam(name = "keyword", defaultValue = "") String keyword,
						Model model) {
		Map<String, Object> map = new HashMap<>();
		
		// 페이징 처리........귀찮다.......
		int size = 10;
		int total = 0;
		
		try {
			keyword = URLDecoder.decode(keyword,"utf-8");
			
			map.put("kwd", keyword);
			
			int dataCount = service.DataCountFaq(map);
			
			total = util.pageCount(dataCount, size);
			
			page = Math.min(page, total);
			
			int offset = (page -1) * size;
			if(offset < 0) offset = 0;
			
			map.put("size", size);
			map.put("offset", offset);
			
			List<Notice> list = service.getListOfFaq(map);
			List<String> tags = service.getCategory();
			
			model.addAttribute("list", list);
			model.addAttribute("tags", tags);
			
		} catch (Exception e) {
			
		}
		return "notice/main";
	}
	
	// 검색은 귀찮아서 못하겠는데 
	// 공지사항 리스트 
	@GetMapping("notlist")
	@ResponseBody
	public Map<String, Object> getNotList(@RequestParam(name = "page", defaultValue = "1") int page) {
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			int size = 10;
			
			int dataCount = service.DataCountNotice(map);
			
			int total = util.pageCount(dataCount, size);
			
			page = Math.min(page, total);
			
			int offset = (page -1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Notice> list = service.getListOfNotice(map);
		
			map.put("page", page);
			map.put("total", total);
			map.put("list", list);
			map.put("state","true");
			
		} catch (Exception e) {
			
		}
		return map;
	}
	
	@GetMapping("article/{num}")
	public String handleArticle(@PathVariable("num") long num, Model model) {
	
		try {
			Notice dto = service.findByIdOfNotice(num);
			model.addAttribute("dto", dto);
		} catch (Exception e) {
		}
		return "notice/article";
	}
	
	
	// 문의 사항 폼띄우기
	@GetMapping("goinquiry")
	public String gointoInquiry() {
		return"";
	}
	
	
	// 문의 사항 리스트 
	@GetMapping("inquire")
	@ResponseBody
	public Map<String, Object> handleInquire() {
		Map<String, Object> map = new HashMap<>();
		try {
			map.put("state", "true");
		} catch (Exception e) {
		}
		return map;
	}
	
}
