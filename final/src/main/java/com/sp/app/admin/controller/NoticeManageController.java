package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.Notice;
import com.sp.app.admin.service.NoticeManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/notice/*")
@Slf4j
@RequiredArgsConstructor
public class NoticeManageController {
	
	private final NoticeManageService service;
	private final PaginateUtil util;
	
	@GetMapping("main")
	public String handleMain(@RequestParam(name = "page", defaultValue = "1")int page,
							Model model) {
		
		try {
			// 페이징 처리해야됨 기차느니까 나중에 ㄱㄱ 
			
			int size = 10;
			int total = 0;
			int dataCount = service.dataCount();
			
			total = util.pageCount(dataCount, size);
			
			page = Math.min(page, total);
			
			int offset = (page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<Notice> list = service.getList(offset, size);
			
			model.addAttribute("list",list);
			
		} catch (Exception e) {
			log.info("===================handleMain : ", e);
		}
		return"admin/noticeList/notice";
	}
	
	@GetMapping("write")
	public String handleWrite() {
		return "admin/noticeList/write";
	}
	
	@PostMapping("save")
	public String handleSubmit(Notice dto, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto.setAdminidx(info.getMemberIdx());
			
			System.out.println(dto.getFixed());
			System.out.println();
			
			map.put("dto", dto);
			map.put("yesOrno", dto.getFixed());
			
			service.insertNotice(map);
			
		} catch (Exception e) {
			log.info("NoticeManageController :", e);
		}
		return "redirect:/admin/notice/main";
	}
	
	
	@GetMapping("article/{num}")
	public String handleArticle(@PathVariable(name = "num") long num, Model model) {
		try {
			Notice dto = Objects.requireNonNull(service.findById(num));
			
			model.addAttribute("dto", dto);
			
		} catch (Exception e) {
			log.info("==============handleArticle : ", e);
		}
		return "admin/noticeList/article";
	}
	
	
}
