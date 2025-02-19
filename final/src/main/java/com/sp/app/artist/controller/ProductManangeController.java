package com.sp.app.artist.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.common.PaginateUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/artist/productManage/*")
public class ProductManangeController{
	private final PaginateUtil paginateUtil;
	
	@GetMapping("list")
	public String list() throws Exception{ 
		
		return "artist/productManage/list";
	}
	
	@GetMapping("write")
	public String writeForm() throws Exception{ 
		
		return "artist/productManage/write";
	}
	
	@PostMapping("write")
	public String writeSubmit() throws Exception{ 
		
		return "artist/productManage/list";
	}
	
	
}
