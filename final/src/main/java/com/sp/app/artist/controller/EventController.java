package com.sp.app.artist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/event/*")
public class EventController {
	
	@GetMapping("/main")
	public String main() {
		return "event/main";
	}
}
