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

import com.sp.app.admin.model.Event;
import com.sp.app.admin.model.Information;
import com.sp.app.admin.model.Notice;
import com.sp.app.admin.service.EventManageService;
import com.sp.app.admin.service.NoticeManageService;
import com.sp.app.common.MyUtil;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/admin/notice/*")
@Slf4j
@RequiredArgsConstructor
public class NoticeManageController {
	
	private final EventManageService eventservice;
	private final NoticeManageService service;
	private final PaginateUtil util;
	
	@GetMapping("main")
	public String handleMain(@RequestParam(name = "page", defaultValue = "1")int page,
							Model model, HttpServletRequest req) {
		String cp = req.getContextPath();
		try {
			int size = 10;
			int total = 0;
			int dataCount = service.dataCount();
			
			total = util.pageCount(dataCount, size);
			
			page = Math.min(page, total);
			
			int offset = (page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<Notice> list = service.getList(offset, size);
			
			String listUrl = cp + "/admin/notice/main?page="+page;
			
			String paging = util.pagingUrl(page, total, listUrl);
			
			model.addAttribute("paging", paging);
			model.addAttribute("list",list);
			
		} catch (Exception e) {
			log.info("===================handleMain : ", e);
		}
		return"admin/noticeList/notice";
	}
	
	@GetMapping("write")
	public String handleWrite(@RequestParam(name = "category", defaultValue = "choose") String category, Model model) {
		
		try {
			if(category.indexOf("event") > -1) {
				model.addAttribute("category", "event");
				String sub = category.substring(category.lastIndexOf("event") + "event".length());
				long num = Long.parseLong(sub);
				
				// event 객체를 num 을 기준으로 반환
				Event dto = eventservice.findByIdOfEvent(num, "comment");
				
				// 해당 event 의 당첨자를 결정 파라미터 size 랑 해당 게시글 num 넘겨야됨
				// 근데 그럴려면 size 를 어디서 결정하냐가 문제 
				// eventservice.insertWinners(null);
				model.addAttribute("dto", dto);
			}
			
		} catch (Exception e) {
			log.info("handleWrite : ", e);
		}
		return "admin/noticeList/write";
	}
	
	@PostMapping("save")
	public String handleSubmit(Notice dto, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			dto.setAdminidx(info.getMemberIdx());
			
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
	
	
	@GetMapping("info")
	public String handleInfo(@RequestParam(name = "page", defaultValue = "1")int page,
							Model model, HttpServletRequest req) {
		String cp = req.getContextPath();
		try {
			int size = 10;
			int total = 0;
			int dataCount = service.dataCount();
			
			total = util.pageCount(dataCount, size);
			
			page = Math.min(page, total);
			
			int offset = (page - 1) * size;
			if(offset < 0) offset = 0;
			
			List<Information> list;
			
			String listUrl = cp + "/admin/notice/info?page="+page;
			
			String paging = util.pagingUrl(page, total, listUrl);
			
			model.addAttribute("paging", paging);
		//	model.addAttribute("list",list);
			
		} catch (Exception e) {
			log.info("===================handleInfo : ", e);
		}
		return"admin/noticeList/information";
	}
	
}
