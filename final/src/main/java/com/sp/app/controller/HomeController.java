package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.MainProduct;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MainProductService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeController {
	
	private final PaginateUtil util;
	private final MainProductService service;
	
	@GetMapping("/")
	public String handleHome(Model model, @RequestParam(name = "page", defaultValue = "1") int page, HttpSession session) {
		
		int total = 0;
		int size = 10;
		int dataCount = 0;
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();
		try {
			
			dataCount = service.totalDataCount(map);
			total = util.pageCount(dataCount, size);
			page = Math.min(page, total);
			
			int offset = (page -1) * size;
			if (offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			map.put("memberidx", info.getMemberIdx());
			
			List<MainProduct> list = service.listRecommendMainProduct(map);

			model.addAttribute("list", list);
			model.addAttribute("page", page);
			model.addAttribute("total", total);
			
		} catch (Exception e) {
			log.info("===============handle Main", e);
		}
		return "main/main";
	}
	
}
