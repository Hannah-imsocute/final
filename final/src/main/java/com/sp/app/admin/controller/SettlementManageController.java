package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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
	public String listSettlement(@RequestParam(name = "mainTab", defaultValue = "1") int mainTab,
			@RequestParam(name = "subTab", defaultValue = "1") int subTab,
			@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "Seller") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model, HttpServletResponse resp)
			throws Exception {
		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;
			int dataCount2 = 0;

			kwd = URLDecoder.decode(kwd, "utf-8");

			Map<String, Object> map = new HashMap<>();
			map.put("mainTab", mainTab);
			map.put("subTab", subTab);
			map.put("schType", schType);
			map.put("kwd", kwd);

			// 데이터 개수 가져오기
			dataCount = service.dataCount(map);
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}

			// 서브탭 2에 대한 데이터 개수 계산
			if (mainTab == 1 && subTab == 2) {
				dataCount2 = service.dataCount2(map); // 서브탭 2에 대한 데이터 개수 가져오기
				if (dataCount2 != 0) {
					total_page = paginateUtil.pageCount(dataCount2, size);
				}
			}

			current_page = Math.min(current_page, total_page);

			List<SettlementManage> list = new ArrayList<>();

			// mainTab과 subTab에 따라 다른 서비스 호출
			if (mainTab == 1) {
				if (subTab == 1) {
					list = service.listSettlementMainTab1SubTab1(map);
				} else if (subTab == 2) {
					list = service.listSettlementMainTab1SubTab2(map);
				}
			} else if (mainTab == 2) {
				if (subTab == 1) {
					list = service.listSettlementMainTab2SubTab1(map);
				} else if (subTab == 2) {
					list = service.listSettlementMainTab2SubTab2(map);
				}
			}

			String paging = paginateUtil.paging(current_page, total_page, "list");

			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("dataCount2", dataCount2);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("mainTab", mainTab);
			model.addAttribute("subTab", subTab);
		} catch (Exception e) {
			log.info("list : ", e);
			resp.sendError(406);
			throw e;
		}

		return "admin/settlementManage/list"; // 서브탭에 맞는 데이터 반환
	}

	// 상세보기 페이지
	@GetMapping("profile")
	public String profile(@RequestParam(name = "settlement_num") String settlement_num,
			@RequestParam(name = "page", defaultValue = "1") int page, Model model) throws Exception {
		try {
			// settlement_num에 맞는 상세 정보 조회
			SettlementManage dto = Objects.requireNonNull(service.findById(settlement_num));

			model.addAttribute("dto", dto);
			model.addAttribute("page", page);

		} catch (Exception e) {
			log.error("profile " + settlement_num, e);
			throw e;
		}

		return "admin/settlementManage/profile"; // 상세보기 뷰
	}

}
