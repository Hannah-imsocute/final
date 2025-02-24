package com.sp.app.artist.controller;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.artist.model.ProductManage;
import com.sp.app.artist.service.ProductManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.MainProduct;
import com.sp.app.model.SessionInfo;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/artist/productManage/*")
public class ProductManageController{
	private final PaginateUtil paginateUtil;
	private final ProductManageService service;
	private final StorageService storageService;
	
	private String uploadPath;
	
	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/product");		
	}	

	
	@GetMapping("write")
	public String writeForm() throws Exception{ 
		
		return "artist/productManage/write";
	}
	
	@PostMapping("write")
	public String writeSubmit() throws Exception{ 
		return "artist/productManage/list";
	}
	
	

	@GetMapping("listMainCategory")
	public String listMainCategory(Model model) throws Exception{
		
		try {
			List<ProductManage> listMainCategory = service.listMainCategory();
			System.out.println("listMainCategory" +listMainCategory );
			
			model.addAttribute("listMainCategory", listMainCategory);
		} catch (Exception e) {
			log.info("listMainCategory : ", e);
		}
		
		return "artist/productManage/write";
	}
	
	@ResponseBody
	@GetMapping("listSubCategory")
	public Map<String, ?> listSubCategory(
			@RequestParam(name = "parentCategoryCode") long parentCategoryCode) throws Exception{
		Map<String, Object> model = new HashMap<>();
			
		try {
			List<ProductManage> listSubCategory = service.listSubCategory(parentCategoryCode);
			System.out.println("listSubCategory" +listSubCategory );
			
			model.put("listSubCategory", listSubCategory);
		} catch (Exception e) {
			log.info("listSubCategory : ", e);
		}
		
		return model;
	}

	@GetMapping("list")
	public String productList(HttpSession session, Model model) throws Exception{
		Map<String, Object> map = new HashMap<>();
		
		try {
			
			List<ProductManage> productList = service.listProduct(map);
			model.addAttribute("productList",productList);
			

		} catch (Exception e) {
			log.info("productList : ", e);
		}
		
		
		return "artist/productManage/list";
	}
	
	
    @PostMapping("create")
    public String createProduct(ProductManage dto,
                                @RequestParam(value = "thumbnailFile", required = true) MultipartFile thumbnailFile,
//                                @RequestParam(value = "addFiles", required = false) MultipartFile[] addFiles,
                                HttpServletRequest request,
                                HttpSession session,
                                Model model) throws Exception {
    	
//    	Long memberIdx = getMemberIdx(session);
//    	dto.setMemberIdx(memberIdx);
    	
    	dto.setMemberIdx(2); // 테스트소스
		
        // 제품(작품) 정보를 DB에 저장하는 신규 메서드
        service.insertProduct(dto, thumbnailFile, uploadPath);
        
        // 등록한 작품 리스트 조회
        Map<String, Object> map = new HashMap<>();
        List<ProductManage> productList = service.listProduct(map);
        
        model.addAttribute("productList",productList);
        // 등록 후 목록 페이지로 리다이렉트 (contextPath 포함)
        
        String contextPath = request.getContextPath();
        return "redirect:" + contextPath + "/artist/productManage/list";
   
    }
    
    
    @PostMapping("delete")
	public String deleteProduct(
			@RequestParam("productCode") Long productCode,
			HttpServletRequest request) throws Exception { 
    	try {
			service.deleteProduct(productCode);
		
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return "redirect:" + request.getContextPath() + "/artist/productManage/list";
    }

    // Session 에서 회원코드 반환
    private static Long getMemberIdx(HttpSession session) {
      SessionInfo member = (SessionInfo) session.getAttribute("member");
      return member.getMemberIdx();
    }
	
}
