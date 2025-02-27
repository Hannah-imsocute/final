package com.sp.app.controller;

import java.net.URLDecoder;
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

import com.sp.app.admin.model.Information;
import com.sp.app.admin.model.Notice;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.NoticeService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import oracle.jdbc.proxy.annotation.Post;

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
		// 키워드 선택 , 페이지
		Map<String, Object> map = new HashMap<>();
		
		int size = 10;
		int total = 0;
		
		try {
			keyword = URLDecoder.decode(keyword,"utf-8");
			
			map.put("kwd", keyword);
			
			int dataCount = service.DataCountFaq(map);
			total = util.pageCount(dataCount, size);
			page = Math.min(page, total);

			String paging = util.pagingMethod(page, total, "loadingFaq");

			
			model.addAttribute("page", page);
			model.addAttribute("total", total);


			int offset = (page -1) * size;
			if(offset < 0) offset = 0;
			
			map.put("size", size);
			map.put("offset", offset);
			
			
			List<Notice> list = service.getListOfFaq(map);
			List<String> tags = service.getCategory();
			
			model.addAttribute("list", list);
			model.addAttribute("tags", tags);
			model.addAttribute("paging", paging);
			model.addAttribute("kwd", keyword);
			
		} catch (Exception e) {
			
		}
		return "notice/main";
	}
	
	
	@GetMapping("notlist")
	@ResponseBody
	public Map<String, Object> getNotList(@RequestParam(name = "page", defaultValue = "1") int page,
										@RequestParam(name = "keyword", defaultValue = "")String kwd, 
										HttpSession session ) {
		
		Map<String, Object> map = new HashMap<>();
		
		try {
			int size = 10;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			map.put("kwd", kwd);
			
			int dataCount = service.DataCountNotice(map);
			
			int total = util.pageCount(dataCount, size);
			
			page = Math.min(page, total);
			
			int offset = (page -1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<Notice> list = service.getListOfNotice(map);
			String paging = util.pagingMethod(page, total, "loadingNotice");
		
			map.put("page", page);
			map.put("total", total);
			map.put("list", list);
			map.put("paging", paging);
			map.put("state","true");
			map.put("kwd", kwd);
			
		} catch (Exception e) {
			
		}
		return map;
	}
	
	// 공지사항 띄우기 
	@GetMapping("article/{num}")
	public String handleArticle(@PathVariable("num") long num, Model model) {
	
		try {
			Notice dto = service.findByIdOfNotice(num);
			model.addAttribute("dto", dto);
		} catch (Exception e) {
		}
		return "notice/article";
	}

	// 공지사항 띄우기 
	@GetMapping("inqarticle/{num}")
	public String handleinqArticle(@PathVariable("num") long num, Model model) {
		
		try {
			Information dto = service.findByIdOfInformation(num);
			
			model.addAttribute("dto", dto);
		} catch (Exception e) {
		}
		return "notice/inqArticle";
	}
	
	// 문의 사항 폼띄우기
	@GetMapping("goinquiry")
	public String gointoInquiry(Model model) {
		return "notice/inquiry";
	}
	
	// 폼 접수
	@PostMapping("inquiries")
	public String handelSubmit(@ModelAttribute Information dto, HttpSession session) {
		
		SessionInfo info = (SessionInfo) session.getAttribute("member");
		try {
			dto.setMemberidx(info.getMemberIdx());
			service.insertInquiry(dto);
		} catch (Exception e) {
		}
		return "redirect:/";
	}
	
	// 문의 사항 리스트 
	@GetMapping("inquire")
	@ResponseBody
	public Map<String, Object> handleInquire(@RequestParam(name = "keyword", defaultValue = "")String kwd,
											@RequestParam(name = "page", defaultValue = "1")int page,
											Model model) {
		Map<String, Object> map = new HashMap<>();
		int size = 10;
		int total = 0;
		int dataCount = 0;
		try {
			kwd = URLDecoder.decode(kwd,"utf-8");
			map.put("kwd", kwd);
			
			dataCount = service.dataCountOfInquiry(kwd);
			total = util.pageCount(dataCount, size);
			
			int offset = (page -1) * size;
			if(offset < 0 ) offset = 0 ;
			
			map.put("offset", offset);
			map.put("size", size);
		
			// 리스트 불러오면 됨 
			List<Information> list = service.getListOfInquiry(map);
			// 페이징 처리
			String paging = util.pagingMethod(page, total, "loadingInquiry");
			
			
			map.put("kwd", kwd);
			map.put("list", list);
			map.put("paging", paging);
			map.put("page", page);
			map.put("total", total);
			map.put("state", "true");
			
			
		} catch (Exception e) {
		}
		return map;
	}
	
}
