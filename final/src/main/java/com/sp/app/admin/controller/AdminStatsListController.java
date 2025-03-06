package com.sp.app.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.service.StatsListService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/statsList/*")
public class AdminStatsListController {
	private final StatsListService service;
	
	@GetMapping("")
	public String memberManage(Model model) throws Exception {

		return "admin/statsList/statsList";
	}
	
	// 회원 연령대별 인원수 : AJAX-JSON 응답
	@ResponseBody
	@GetMapping("memberAgeSection")
	public Map<String, ?> memberAgeSection() throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		// 연령대별 인원수
		List<Map<String, Object>> list = service.listAgeSection();

		model.put("list", list);

		return model;
	}	
	
	@ResponseBody
	@GetMapping("memberStatus")
	public Map<String, ?> memberStatus() throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		// 연령대별 인원수
		List<Map<String, Object>> list = service.memberStatus();

		model.put("list", list);

		return model;
	}	
}