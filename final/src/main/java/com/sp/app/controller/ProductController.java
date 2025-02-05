package com.sp.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.MainProduct;
import com.sp.app.service.MainProductService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/product/*")
public class ProductController {
	private final MainProductService service;
	private final PaginateUtil paginateUtil;

	@RequestMapping("category")
	public String category(
			@RequestParam(name = "categoryCode", defaultValue = "1") int categoryCode,
			@RequestParam(name = "page", defaultValue = "1") int current_page, 
			Model model,
			HttpServletRequest req ) throws Exception{
		
		try {
			int size = 10;
			int total_page;
			int dataCount;
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("categoryCode", categoryCode);
			
			//카테고리 정보
			MainProduct categoryDto = Objects.requireNonNull(service.findByCategoryId(categoryCode));
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MainProduct> list = service.listMainProduct(map);
			
			String cp = req.getContextPath();
			String listUrl = cp + "/product/category?categoryCode=" + categoryCode;
			String paging = paginateUtil.paging(current_page, total_page, listUrl);
			
			model.addAttribute("list",list);
			model.addAttribute("categoryCode",categoryCode);
			model.addAttribute("name",categoryDto.getName());
			model.addAttribute("page",current_page);
			model.addAttribute("dataCount",dataCount);
			model.addAttribute("size",size);
			model.addAttribute("total_page",total_page);
			model.addAttribute("paging",paging);
			
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("main : ", e  );
		}
		
		return "product/category";
	}

}
