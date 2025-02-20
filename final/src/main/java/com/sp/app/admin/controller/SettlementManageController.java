package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.admin.service.SettlementManageService;
import com.sp.app.common.PaginateUtil;

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
}
