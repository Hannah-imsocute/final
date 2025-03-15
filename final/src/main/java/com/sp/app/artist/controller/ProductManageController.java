package com.sp.app.artist.controller;

import java.io.File;
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



	@GetMapping("list")
	public String productList(HttpSession session, Model model) throws Exception{
		Long memberIdx = getMemberIdx(session);

		try {
			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", memberIdx); 
			
			List<ProductManage> productList = service.listProduct(map);
			model.addAttribute("productList",productList);

		} catch (Exception e) {
			log.info("productList : ", e);
		}
		
		
		return "artist/productManage/list";
	}
	
	@ResponseBody
	@GetMapping("listMainCategory")
	public  Map<String, ?> listMainCategory() throws Exception{
		Map<String, Object> model = new HashMap<>();
		try {
			List<ProductManage> listMainCategory = service.listMainCategory();
			System.out.println("listMainCategory" +listMainCategory );
			
			model.put("listMainCategory", listMainCategory);
		} catch (Exception e) {
			log.info("listMainCategory : ", e);
		}
		
		return model;
	}
	
	@ResponseBody
	@GetMapping("listSubCategory")
	public Map<String, ?> listSubCategory(
			@RequestParam(name = "parentCategoryCode") int parentCategoryCode) throws Exception{
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
	
	 @GetMapping("write")
	    public String writeForm(Model model) throws Exception {
	    
	    	try {
	    		List<ProductManage> listMainCategory = service.listMainCategory();
				List<ProductManage> listSubCategory = null;
	    		
				long parentCategoryCode= 0;
				
				if(listMainCategory.size() > 0) {
					parentCategoryCode = listMainCategory.get(0).getCategoryCode();
				}
				listSubCategory = service.listSubCategory(parentCategoryCode);		
				model.addAttribute("mode","write");
	    	    model.addAttribute("listMainCategory",listMainCategory);
	    	    model.addAttribute("listSubCategory",listSubCategory);
	   
			} catch (Exception e) {
				log.info("writeForm : " , e);
			}
	    	return "artist/productManage/write";
	       
	    }
		
    @PostMapping("write")
    public String writeSubmit(ProductManage dto,
                                HttpServletRequest request,
                                HttpSession session,
                                Model model) throws Exception {
    	
    	Long memberIdx = getMemberIdx(session);
      	dto.setMemberIdx(memberIdx); // 테스트소스

    	// 제품(작품) 정보를 DB에 저장하는 신규 메서드
        service.insertProduct(dto, uploadPath);
        
        // 등록한 작품 리스트 조회
        Map<String, Object> map = new HashMap<>();
        
        map.put("memberIdx", memberIdx); 
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
    
    @GetMapping("article")
    public String article(Model model) {
    	try {
			
		} catch (Exception e) {
			// TODO: handle exception
		}
    	return "artist/productManage/article";
    	
    }
    
    @GetMapping("update")
    public String updateForm(
    		@RequestParam("productCode") long productCode,
    		@RequestParam("categoryCode") int categoryCode,
    		@RequestParam("parentCategoryCode") int parentCategoryCode,
//	    	@RequestParam(name = "page") String page,
    		HttpServletRequest request,
    		Model model) throws Exception {
    	try {
			ProductManage dto = Objects.requireNonNull(service.findById(productCode));
			
			//카테고리
			List<ProductManage> listMainCategory = service.listMainCategory();
			List<ProductManage> listSubCategory = service.listSubCategory(parentCategoryCode);
			
			//추가 이미지
			List<ProductManage> listAddFiles = service.listAddFiles(productCode);
		
			//옵션1/옵션2 옵션명
			List<ProductManage> listProductOption = service.listProductOption(productCode);

			//옵션1/옵션2 상세옵션
			List<ProductManage> listOptionDetail = null;
			List<ProductManage> listOptionDetail2 = null;
			if(listProductOption.size() > 0) {
				dto.setOption_code(listProductOption.get(0).getOption_code());
				dto.setOption_name(listProductOption.get(0).getOption_name());
				listOptionDetail = service.listOptionDetail(listProductOption.get(0).getOption_code());
			}
			if(listProductOption.size() > 1) {
				dto.setOption_code2(listProductOption.get(1).getOption_code());
				dto.setOption_name2(listProductOption.get(1).getOption_name());
				listOptionDetail2 = service.listOptionDetail(listProductOption.get(1).getOption_code());
			}
			dto.setOptionCount(listProductOption.size());
			
			model.addAttribute("mode", "update");
			model.addAttribute("dto", dto);
			model.addAttribute("listMainCategory", listMainCategory);
			model.addAttribute("listSubCategory", listSubCategory);
			model.addAttribute("listAddFiles", listAddFiles);
			model.addAttribute("listOptionDetail", listOptionDetail);
			model.addAttribute("listOptionDetail2", listOptionDetail2);
//		    model.addAttribute("page", page);
			
			return "artist/productManage/write";
			

		} catch (Exception e) {
			// TODO: handle exception
		}
//    	String qs = "parentCategoryCode=" + parentCategoryCode + "&categoryCode=" + categoryCode + "&page=" + page;
    	String qs = "parentCategoryCode=" + parentCategoryCode + "&categoryCode=" + categoryCode;
    	return "redirect:/artist/productManage/list/" + "?" + qs;
    }
    

    
    @PostMapping("update")
    public String updateSubmit(ProductManage dto,
    		
    		//@RequestParam(name="page") String page,
    		Model model ) throws Exception {
    	try {
			service.updateProduct(dto, uploadPath);
		} catch (Exception e) {
			log.info("updateSubmit : ", e);
		}

//    	String qs = "parentCategoryCode=" + dto.getParentCategoryCode() + "&categoryCode=" + dto.getCategoryCode() + "&page=" + page;

        return "redirect:/artist/productManage/list";

    }
    
    @ResponseBody
    @PostMapping("deleteFile")
  	public Map<String, ?> deleteFile(
  			@RequestParam(name = "image_code") long image_code,
  			@RequestParam(name = "imageFileName") String imageFileName
  		) throws Exception { 
      	
    	System.out.println("image_code"+image_code);
    	System.out.println("imageFileName"+imageFileName);
    	
    	Map<String, Object> model = new HashMap<>();
      	
      	String state = "false";
    	try {
    		String pathString = uploadPath + File.separator + imageFileName;
      		service.deleteProductFile(image_code, pathString);
  		
      		state = "true";
  		} catch (Exception e) {
  			// TODO: handle exception
  		}
    	model.put("state", state);
      	return model;
      }

    
 
    
    
}

    
    
   
