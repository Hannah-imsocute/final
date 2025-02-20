package com.sp.app.artist.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
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

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
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

    @PostMapping("create")
    public String createProduct(ProductManage product,
                                @RequestParam("thumbnail") MultipartFile thumbNail,
                                @RequestParam(value = "imagefilename", required = false) MultipartFile[] imagefileName,
                                HttpServletRequest request) throws Exception {
        // 메인 이미지 업로드 처리
        if (thumbNail != null && !thumbNail.isEmpty()) {
            String mainFilename = storageService.uploadFileToServer(thumbNail, uploadPath);
            product.setThumbnail(mainFilename);
        }
        
        // 추가 이미지 다중 업로드 처리
        if (imagefileName != null && imagefileName.length > 0) {
            List<String> additionalFilenames = new ArrayList<>();
            for (MultipartFile file : imagefileName) {
                if (!file.isEmpty()) {
                    String filename = storageService.uploadFileToServer(file, uploadPath);
                    additionalFilenames.add(filename);
                }
            }
            /* TODO: 아래로직대로 하면 PRODUCTIMAGE 테이블에 1 ROW에 한방에 여러개 파일 저장되니 
             *       for 사용해서 추가로 서비스도 호출해서 여러개 row 로 테이블에 등록되도록 수정해야함
             *       그리고 mapper .xml 에 쿼리도 수정해야하고 
             *       productOption 테이블에 등록하는 옵션등록 서비스도 만들어야해요 파이팅!!!
             */
            // 여러 파일명을 콤마(,)로 구분하여 저장
            product.setImageFileName(String.join(",", additionalFilenames));
        }
        
        // 제품(작품) 정보를 DB에 저장하는 신규 메서드
        service.insertProduct(product);
        
        // 등록 후 목록 페이지로 리다이렉트 (contextPath 포함)
        String contextPath = request.getContextPath();
        return "redirect:" + contextPath + "/artist/productManage/list";
    }
	
}
