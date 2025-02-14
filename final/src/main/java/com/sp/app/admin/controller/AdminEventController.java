package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/event/*")
public class AdminEventController {
	
	@GetMapping("main")
	public String handleMain() {
		return "admin/eventList/event";
	}
	
	@GetMapping("write")
	public String handleWriteForm() {
		return "";
	}
}
