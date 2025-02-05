package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class HomeManageController {
	 
	@GetMapping("/admin")
	public String handleHome() {
		return "admin/home";
	}
	
	@RequestMapping("/admin")
	public class AdminController {

	    @GetMapping("/{page}")
	    public String loadPage(@PathVariable String page) {
	        return "admin/" + page; // JSP 페이지 이름 반환
	    }
	}


}
