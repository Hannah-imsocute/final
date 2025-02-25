package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.model.SettlementManage;
import com.sp.app.admin.service.SettlementManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/settlementManage/*")
public class SettlementManageController {
	private final SettlementManageService service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("")
	public String SettlementManage(Model model) throws Exception {
		
		return "admin/settlementManage/settlementManage";
	}
	
	@GetMapping("list")
	public String listSettlement(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "Seller") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			Model model,
			HttpServletResponse resp) throws Exception {
		
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			
			kwd = URLDecoder.decode(kwd, "utf-8");
			
			// 전체 페이지 수
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("schType", schType);
			map.put("kwd", kwd);
			
			dataCount = service.dataCount(map);
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}
			
			current_page = Math.min(current_page, total_page);
			
			List<SettlementManage> list = service.listSettlement(map);	
			
			String paging = paginateUtil.paging(current_page, total_page, "subTabContent1");
			
			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
		
		} catch (Exception e) {
			log.info("list : ", e);
			
			resp.sendError(406);
			throw e;
		}
		
		return "admin/settlementManage/list";
	}
	
	

}
