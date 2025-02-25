package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.Report;
import com.sp.app.admin.service.AdminReportService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller()
@RequestMapping("/admin/report/*")
@RequiredArgsConstructor
@Slf4j
public class AdminReportManageController {

	private final AdminReportService service;
	private final PaginateUtil pageUtil;

	// 작품 후기 신고
	@GetMapping("main")
	public String getMain(@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "category", defaultValue = "0") String category,
			@RequestParam(name = "keyword", defaultValue = "") String kwd, Model model, HttpServletRequest request) {
		int size = 10;
		int total = 0;
		int dataCount = 0;
		String cp = request.getContextPath();
		try {
			// 페이징 처리부터 단, 검색 조건이 존재 할 수 있음

			Map<String, Object> map = new HashMap<>();

			// 카테고리별 보기
			map.put("category", category);
			// 카테고리 + 키워드 보기
			map.put("kwd", URLDecoder.decode(kwd, "utf-8"));
			// 그냥 보기

			dataCount = service.dataCountOfProduct(map);
			total = pageUtil.pageCount(dataCount, size);

			int current = Math.min(Integer.parseInt(page), total);

			int offset = (current - 1) * size;
			if (offset < 0)
				offset = 0;

			// 리스트 불러오고
			List<Report> list = service.getListOfProduct(map);

			String listUrl = cp + "/admin/report/main?page=" + page + "&category=" + category + "&keyword="
					+ URLEncoder.encode(kwd, "utf-8");

			// 페이징처리합시다
			String paging = pageUtil.pagingUrl(current, total, listUrl);

			List<Report> categorylist = service.getCategoryOfReport();

			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			model.addAttribute("categorylist", categorylist);
			model.addAttribute("category", category);
			model.addAttribute("keyword", kwd);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("total", total);
			model.addAttribute("page", page);

		} catch (Exception e) {
			log.info("=====================getMain", e);
		}
		return "admin/reportList/report";
	}

	@GetMapping("reviews")
	public String handleContent(@RequestParam(name = "page", defaultValue = "1") String page,
			@RequestParam(name = "category", defaultValue = "0") String category,
			@RequestParam(name = "keyword", defaultValue = "") String kwd, Model model, HttpServletRequest request) {
		int size = 10;
		int total = 0;
		int dataCount = 0;
		String cp = request.getContextPath();
		try {
			// 페이징 처리부터 단, 검색 조건이 존재 할 수 있음

			Map<String, Object> map = new HashMap<>();

			// 카테고리별 보기
			map.put("category", category);
			// 카테고리 + 키워드 보기
			map.put("kwd", URLDecoder.decode(kwd, "utf-8"));
			// 그냥 보기

			dataCount = service.dataCountOfReviews(map);
			total = pageUtil.pageCount(dataCount, size);

			int current = Math.min(Integer.parseInt(page), total);

			int offset = (current - 1) * size;
			if (offset < 0)
				offset = 0;

			// 리스트 불러오고
			List<Report> list = service.getListOfReviews(map);

			String listUrl = cp + "/admin/report/reviews?page=" + page + "&category=" + category + "&keyword="
					+ URLEncoder.encode(kwd, "utf-8");

			// 페이징처리합시다
			String paging = pageUtil.pagingUrl(current, total, listUrl);

			List<Report> categorylist = service.getCategoryOfReport();

			model.addAttribute("list", list);
			model.addAttribute("paging", paging);
			model.addAttribute("categorylist", categorylist);
			model.addAttribute("category", category);
			model.addAttribute("keyword", kwd);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("total", total);
			model.addAttribute("page", page);

		} catch (Exception e) {
			log.info("=====================getMain", e);
		}
		return "admin/reportList/content";
	}
	
	@PostMapping("details")
	@ResponseBody
	public Map<String, Object> details(@RequestParam(name = "num") long num , @RequestParam(name = "mode") String mode){
		Map<String, Object> map = new HashMap<>();
		try {
			// findById 해서 해당 정보 뿌리기 
			map.put("mode", mode);
			map.put("num", num);
			Report dto = service.findById(map);
			
			map.put("state", "true");
			map.put("dto", dto);
		} catch (Exception e) {
		}
		return map;
	}
}
