package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.Information;
import com.sp.app.admin.model.Notice;
import com.sp.app.admin.service.EventManageService;
import com.sp.app.admin.service.NoticeManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
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
	public String handleMain(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model, HttpServletRequest req) {

		String cp = req.getContextPath();

		try {

			int size = 10;
			int total = 0;
			kwd = URLDecoder.decode(kwd, "utf-8");

			int dataCount = service.dataCount(kwd);

			total = util.pageCount(dataCount, size);

			page = Math.min(page, total);

			int offset = (page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<Notice> list = service.getList(offset, size, kwd);

			String listUrl = cp + "/admin/notice/main?page=" + page + "&kwd=" + URLEncoder.encode(kwd, "utf-8");

			String paging = util.pagingUrl(page, total, listUrl);

			model.addAttribute("paging", paging);
			model.addAttribute("list", list);

		} catch (Exception e) {
			log.info("================handleMain", e);
		}
		return "admin/noticeList/notice";
	}

	@GetMapping("info")
	public String hanleInfo(@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model, HttpServletRequest req) {

		String cp = req.getContextPath();

		try {

			int size = 10;
			int total = 0;
			kwd = URLDecoder.decode(kwd, "utf-8");

			int dataCount = service.dataCountOfInfo(kwd);

			total = util.pageCount(dataCount, size);

			page = Math.min(page, total);

			int offset = (page - 1) * size;
			if (offset < 0)
				offset = 0;

			List<Information> list = service.getListOfInfo(offset, size, kwd);

			String listUrl = cp + "/admin/notice/info?page=" + page + "&kwd=" + URLEncoder.encode(kwd, "utf-8");

			String paging = util.pagingUrl(page, total, listUrl);

			model.addAttribute("paging", paging);
			model.addAttribute("list", list);

		} catch (Exception e) {
			log.info("================handleMain", e);
		}
		return "admin/noticeList/information";
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

	// 수정 마무리 안됨 jsp 작업 중 
	@GetMapping("edit/{num}")
	public String handleEdit(@PathVariable(name = "num") long num , Model model) {
		try {
			Notice dto = Objects.requireNonNull(service.findById(num));

			model.addAttribute("dto", dto);
			model.addAttribute("mode", "edit");
		} catch (Exception e) {
			
		}
		return "admin/noticeList/update";
	}
	
}
