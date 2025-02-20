package com.sp.app.artist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.artist.model.ProductManage;
import com.sp.app.artist.service.ProductManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/artist/productManage/*")
public class ProductManangeController{
	private final PaginateUtil paginateUtil;
	private final ProductManageService service;
	private final StorageService storageService;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/product");		
	}	
	
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
		System.out.println("혹시 여기도 탔나?");
		return "artist/productManage/list";
	}
	
	@ResponseBody
	@GetMapping("listSubCategory")
	public Map<String, ?> listSubCategory(
			@RequestParam(name = "parentCategoryCode") long parentCategoryCode) throws Exception{
		Map<String, Object> model = new HashMap<>();
			
		try {
			List<ProductManage> listMainCategory = service.listMainCategory();
			List<ProductManage> listSubCategory = service.listSubCategory(parentCategoryCode);
			System.out.println("listCategory" +listMainCategory );
			System.out.println("listSubCategory" +listSubCategory );
			
			model.put("listMainCategory", listMainCategory);
			model.put("listSubCategory", listSubCategory);
		} catch (Exception e) {
			log.info("listSubCategory : ", e);
		}
		
		return model;
	}
	
	
}
