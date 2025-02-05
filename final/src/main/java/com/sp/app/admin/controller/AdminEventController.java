package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/adminevent/")
@Slf4j
public class AdminEventController {
	
	@GetMapping("/main")
	public String eventMain() {
		return "admin/event";
	}
	
}
