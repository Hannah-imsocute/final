package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.service.AdminReportService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/*")
public class HomeManageController {
	 
	private final AdminReportService service;
	
	@GetMapping("/home")
	public String handleHome() {
		return "admin/template";
	}

	@GetMapping("/report")
	public String showList() {
		return "admin/report";
	}
	
}
