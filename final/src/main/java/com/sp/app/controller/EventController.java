package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.service.EventService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/event/*")
@RequiredArgsConstructor
@Slf4j
public class EventController {

	private final EventService service;
	
	
	@GetMapping("main")
	public String handleMain(
			@RequestParam(name = "page" , defaultValue = "1") String page ,
			Model model
			) {
		
		try {
			
			int size = 10;
			int total = 0;
			
			
			
			
		} catch (Exception e) {
			log.info("==============controller handleMain : ", e);
		}
		
		return "event/main";
	}
}
