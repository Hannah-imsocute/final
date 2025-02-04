package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/products/*")
public class ProductController {

	public String main() throws Exception{
		return "products/category";
	}

}
