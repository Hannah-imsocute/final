package com.sp.app.controller;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;

import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.MainProduct;
import com.sp.app.service.MainProductService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/product/*")
public class ProductController {
	private final MainProductService service;
	private final PaginateUtil paginateUtil;
    
	@GetMapping("main")
	public ModelAndView main(HttpServletRequest req ) throws Exception{ 
		ModelAndView mav = new ModelAndView("product/main");
		try {
			log.info("Main page accessed");
		} catch (NullPointerException e) {
			log.error("NullPointerException in main(): ", e);
		} catch (Exception e) {
			log.info("main : ", e  );
		}
		
		return mav;
	}
	
	@GetMapping("category") 
	public ResponseEntity<Map<String, Object>> category(
			@RequestParam(name = "categoryName") String categoryName,
			@RequestParam(name = "page", defaultValue = "1") int current_page, 
			HttpServletRequest req ) throws Exception{
		
		System.out.println("categoryName : " + categoryName);
		
		 Map<String, Object> response = new HashMap<>();
		
		try {
			// 받아온 카테고리명을 카테고리코드로 변환
			 Map<String, Integer> categoryMap = Map.of(
		                "bakery"    , 1,  // 베이커리/전통간식
		                "beverage"  , 2,  // 음료/주류
		                "food"      , 3,  // 요리/간편식
		                "nongsusan" , 4   // 농수산품
		        );

		        if (!categoryMap.containsKey(categoryName)) {
		            return ResponseEntity.badRequest().body(Map.of("error", "유효하지 않은 카테고리명입니다."));
		        }

		    int categoryCode = categoryMap.get(categoryName); // 카테고리명을 카테고리코드로 변환
			int size = 10;  // 페이지 당 포함 컨텐츠 수
		//	int size = 1;  // 페이지 당 포함 컨텐츠 수
			int total_page; // 전체 페이지 수
			int dataCount;  // 전체 데이터 컨텐츠 수
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("categoryCode", categoryCode);

			System.out.println("categoryCode : " + categoryCode);
			//카테고리 정보
			MainProduct categoryDto = Objects.requireNonNull(service.findByCategoryId(categoryCode));
			System.out.println("categoryDto: " + categoryDto);
			
			System.out.println("11111111");
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MainProduct> list = service.listMainProduct(map); // 실제 페이징기준으로 데이터 가져오는 부분
			
			// 페이징처리부분
//			String cp = req.getContextPath();
//			String listUrl = cp + "/product/category?categoryName=" + categoryName;
//			String paging = paginateUtil.paging(current_page, total_page, listUrl);

//			System.out.println("listUrl : " + listUrl);
//			System.out.println("paging : " + paging);
//			
			response.put("list", list);
			response.put("categoryName", categoryName);		
            response.put("categoryCode", categoryCode);
            response.put("page", current_page);
            response.put("dataCount", dataCount);
            response.put("size", size);
            response.put("total_page", total_page);
//            response.put("paging", paging);

			
		} catch (NullPointerException e) {
			log.info("main NullPointerException : ", e  );
		} catch (Exception e) {
			log.info("main Exception : ", e  );
		    return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		}
		return ResponseEntity.ok(response);
		
	}

	@GetMapping("{productCode}")
	public ModelAndView productDetail(@PathVariable("productCode") long productCode,
			Model model) throws Exception{
			ModelAndView mav = new ModelAndView("product/detail");

		
		try {
			//상품
			MainProduct dto = Objects.requireNonNull(service.findById(productCode));
			System.out.println(productCode);
	//		List<MainProduct> listFile = service.listMainProductFile(productCode);
					    
		    NumberFormat formatter = NumberFormat.getInstance(Locale.KOREA);
		    
		    String fmdPrice = formatter.format(dto.getPrice());
		    String fmdSalePrice= formatter.format(dto.getSalePrice());
		    

		    String categoryName = dto.getName();
		    System.out.println(categoryName);
		    
		    String categoryUrl = "/product/category?categoryName="+categoryName;
		    
		    mav.addObject("dto", dto);
		    mav.addObject("fmdPrice", fmdPrice);
		    mav.addObject("fmdSalePrice", fmdSalePrice);
		    mav.addObject("categoryUrl",categoryUrl);
		    
//		    mav.setViewName("redirect:" + categoryUrl);
		    
		} catch (NullPointerException e) {
			log.info("detailRequest NullPointerException : ", e  );
		} catch (Exception e) {
			log.info("detailRequest Exception : ", e  );
			
		}
		return mav;
		
	}
	


}
