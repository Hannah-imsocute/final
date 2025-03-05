package com.sp.app.controller;

import java.text.NumberFormat;
import java.util.AbstractMap;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sp.app.artist.model.ProductManage;
import com.sp.app.artist.service.ProductManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.MainProduct;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.ViewProduct;
import com.sp.app.service.MainProductService;
import com.sp.app.service.ViewService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/product/*")
public class ProductController {
	private final MainProductService service;
	private final ProductManageService productManageServcie; 
	private final PaginateUtil paginateUtil;
	private final ViewService viewService;

	// 카테고리명 카테고리코드로 변환
    public static final Map<String, Integer> categoryMap = Map.ofEntries(
    		new AbstractMap.SimpleEntry<>("food"               ,  1),  // 식품
    		new AbstractMap.SimpleEntry<>("fashion"            ,  2),  // 패션
    		new AbstractMap.SimpleEntry<>("living"             ,  3),  // 리빙
    		new AbstractMap.SimpleEntry<>("stationeryMisc"     ,  4),  // 문구/기타용품
    		new AbstractMap.SimpleEntry<>("beauty"             ,  5),  // 뷰티
    		
            new AbstractMap.SimpleEntry<>("bakery"             ,  6),  // 베이커리/전통간식
    		new AbstractMap.SimpleEntry<>("beverage"           ,  7),  // 음료/주류
    		new AbstractMap.SimpleEntry<>("dish"               ,  8),  // 요리/간편식
    		new AbstractMap.SimpleEntry<>("nongsusan"          ,  9),  // 농수산품
    		new AbstractMap.SimpleEntry<>("clothing"           , 10),  // 의류
    		new AbstractMap.SimpleEntry<>("jewelry"            , 11),  // 주얼리
    		new AbstractMap.SimpleEntry<>("fashion-accessory"  , 12),  // 패션잡화
    		new AbstractMap.SimpleEntry<>("camping"            , 13),  // 캠핑
    		new AbstractMap.SimpleEntry<>("furniture"          , 14),  // 가구
    		new AbstractMap.SimpleEntry<>("home-decor"         , 15),  // 홈데코
    		new AbstractMap.SimpleEntry<>("kitchenware"        , 16),  // 주방용품
    		new AbstractMap.SimpleEntry<>("bathroom"           , 17),  // 욕실용품
    		new AbstractMap.SimpleEntry<>("case"               , 18),  // 케이스
    		new AbstractMap.SimpleEntry<>("stationery"         , 19),  // 문구용품
    		new AbstractMap.SimpleEntry<>("party-supplies"     , 20),  // 파티용품
    		new AbstractMap.SimpleEntry<>("car-accessory"      , 21),  // 차량용품
    		new AbstractMap.SimpleEntry<>("skincare"           , 22),  // 스킨케어
    		new AbstractMap.SimpleEntry<>("hair-body-cleansing", 23),  // 헤어/바디/클렌징
    		new AbstractMap.SimpleEntry<>("perfume"            , 24),  // 향수
    		new AbstractMap.SimpleEntry<>("makeup"             , 25)   // 메이크업
        );

	@GetMapping("category")
	public ModelAndView category(HttpServletRequest req ) throws Exception{ 
		ModelAndView mav = new ModelAndView("product/category");
		try {
			log.info("category page accessed");
		} catch (NullPointerException e) {
			log.error("NullPointerException in main(): ", e);
		} catch (Exception e) {
			log.info("category : ", e  );
		}
		
		return mav;
	}
	
	@GetMapping("recommend")
	public ModelAndView recommend(HttpServletRequest req ) throws Exception{ 
		ModelAndView mav = new ModelAndView("product/recommend");
		try {
			log.info("Main page accessed");
		} catch (NullPointerException e) {
			log.error("NullPointerException in main(): ", e);
		} catch (Exception e) {
			log.info("main : ", e  );
		}
		
		return mav;
	}
	
	
	@GetMapping("popular")
	public ModelAndView popular(HttpServletRequest req ) throws Exception{ 
		ModelAndView mav = new ModelAndView("product/popular");
		try {
			log.info("Main page accessed");
		} catch (NullPointerException e) {
			log.error("NullPointerException in main(): ", e);
		} catch (Exception e) {
			log.info("main : ", e  );
		}
		
		return mav;
	}
	

	// 작품 카테고리 별 초화면(메인) 
	@ResponseBody
	@GetMapping("categoryMain") 
	public ResponseEntity<Map<String, Object>> categoryMain(
			@RequestParam(name = "page", defaultValue = "1") int current_page, 
			HttpServletRequest req ) throws Exception{

		 Map<String, Object> response = new HashMap<>();
		
		try {

			int size = 15;  // 페이지 당 포함 컨텐츠 수
			int total_page; // 전체 페이지 수
			int dataCount;  // 전체 데이터 컨텐츠 수
			
			Map<String, Object> map = new HashMap<String, Object>();


			
			dataCount = service.totalDataCount(map);
			System.out.println("dataCount : " + dataCount);
			total_page = paginateUtil.pageCount(dataCount, size); //3 
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MainProduct> list = service.listCategoryMainProduct(map); // 실제 페이징기준으로 데이터 가져오는 부분
			response.put("list", list);			
            response.put("page", current_page);
            response.put("dataCount", dataCount);
            response.put("size", size);
            response.put("total_page", total_page);
			
            System.out.println("####### current_page : " + current_page);
            System.out.println("####### total_page : " + total_page);
            
		} catch (NullPointerException e) {
			log.info("main NullPointerException : ", e  );
			return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		} catch (Exception e) {
			log.info("main Exception : ", e  );
		    return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		}
		return ResponseEntity.ok(response);
		
	}
	
	// 인기작품 순 작품 조회 초화면(메인) 
		@ResponseBody
		@GetMapping("popularMain") 
		public ResponseEntity<Map<String, Object>> popularMain(
				@RequestParam(name = "page", defaultValue = "1") int current_page, 
				HttpServletRequest req ) throws Exception{

			 Map<String, Object> response = new HashMap<>();
			
			try {

				int size = 15;  // 페이지 당 포함 컨텐츠 수
				int total_page; // 전체 페이지 수
				int dataCount;  // 전체 데이터 컨텐츠 수
				
				Map<String, Object> map = new HashMap<String, Object>();
				
				dataCount = service.totalDataCount(map);
				total_page = paginateUtil.pageCount(dataCount, size);
				
				current_page = Math.min(current_page, total_page);
				
				int offset = (current_page - 1) * size;
				if(offset < 0) offset = 0;
				
				map.put("offset", offset);
				map.put("size", size);
				
				List<MainProduct> list = service.listPopularMainProduct(map); // 실제 페이징기준으로 데이터 가져오는 부분
				
				System.out.println(current_page);
				System.out.println(total_page);
				
				response.put("list", list);			
	            response.put("page", current_page);
	            response.put("dataCount", dataCount);
	            response.put("size", size);
	            response.put("total_page", total_page);
	            
				
			} catch (NullPointerException e) {
				log.info("main NullPointerException : ", e  );
				return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
			} catch (Exception e) {
				log.info("main Exception : ", e  );
			    return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
			}
			return ResponseEntity.ok(response);
			
		}
		
		// 추천작품 순 작품 조회 초화면(메인) 
		@ResponseBody
		@GetMapping("recommendMain") 
		public ResponseEntity<Map<String, Object>> recommendMain(
				@RequestParam(name = "page", defaultValue = "1") int current_page, 
				HttpServletRequest req, HttpSession session ) throws Exception{

			Map<String, Object> response = new HashMap<>();
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			try {

				int size = 15;  // 페이지 당 포함 컨텐츠 수
				int total_page; // 전체 페이지 수
				int dataCount;  // 전체 데이터 컨텐츠 수
				
				Map<String, Object> map = new HashMap<String, Object>();
				
				dataCount = service.totalDataCount(map);
				total_page = paginateUtil.pageCount(dataCount, size);
				
				current_page = Math.min(current_page, total_page);
				
				int offset = (current_page - 1) * size;
				if(offset < 0) offset = 0;
				
				map.put("offset", offset);
				map.put("size", size);
				map.put("memberidx", info.getMemberIdx());
				
				List<MainProduct> list = service.listRecommendMainProduct(map); // 실제 페이징기준으로 데이터 가져오는 부분
				
				response.put("list", list);			
	            response.put("page", current_page);
	            response.put("dataCount", dataCount);
	            response.put("size", size);
	            response.put("total_page", total_page);
				
			} catch (NullPointerException e) {
				log.info("main NullPointerException : ", e  );
				return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
			} catch (Exception e) {
				log.info("main Exception : ", e  );
			    return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
			}
			return ResponseEntity.ok(response);
			
		}
		

	// 작품 카테고리 별 조회
	@ResponseBody
	@GetMapping("byCategoryWorks") 
	public ResponseEntity<Map<String, Object>> byCategoryWorks(
			@RequestParam(name = "categoryName") String categoryName,
			@RequestParam(name = "page", defaultValue = "1") int current_page, 
			HttpServletRequest req ) throws Exception{
		
		System.out.println("categoryName : " + categoryName);

		 Map<String, Object> response = new HashMap<>();
		
		try {
			// 받아온 카테고리명을 카테고리코드로 변환
	        if (!categoryMap.containsKey(categoryName)) {
	            return ResponseEntity.badRequest().body(Map.of("error", "유효하지 않은 카테고리명입니다."));
	        }

		    int categoryCode = categoryMap.get(categoryName); // 카테고리명을 카테고리코드로 변환
		    
		    int size = 15;  // 페이지 당 포함 컨텐츠 수
			int total_page; // 전체 페이지 수
			int dataCount;  // 전체 데이터 컨텐츠 수
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("categoryCode", categoryCode);
			
		
			System.out.println("카테고리코드"+categoryCode);
			
			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);
			
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;
			
			map.put("offset", offset);
			map.put("size", size);
			
			List<MainProduct> list = service.listCategoryProduct(map); // 실제 페이징기준으로 데이터 가져오는 부분
			response.put("list", list);			
			response.put("categoryName", categoryName);		
            response.put("categoryCode", categoryCode);
            response.put("page", current_page);
            response.put("dataCount", dataCount);
            response.put("size", size);
            response.put("total_page", total_page);
			
		} catch (NullPointerException e) {
			log.info("main NullPointerException : ", e  );
			return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		} catch (Exception e) {
			log.info("main Exception : ", e  );
		    return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		}
		return ResponseEntity.ok(response);
		
	}
	
	
	// 인기작품 별 조회
		@ResponseBody
		@GetMapping("byPopularWorks") 
		public ResponseEntity<Map<String, Object>> byPopularWorks(
				@RequestParam(name = "categoryName") String categoryName,
				@RequestParam(name = "page", defaultValue = "1") int current_page, 
				HttpServletRequest req ) throws Exception{
			
			System.out.println("categoryName : " + categoryName);
			
			 Map<String, Object> response = new HashMap<>();
			
			try {
				// 받아온 카테고리명을 카테고리코드로 변환
		        if (!categoryMap.containsKey(categoryName)) {
		            return ResponseEntity.badRequest().body(Map.of("error", "유효하지 않은 카테고리명입니다."));
		        }

			    int categoryCode = categoryMap.get(categoryName); // 카테고리명을 카테고리코드로 변환
				int size = 15;  // 페이지 당 포함 컨텐츠 수
				int total_page; // 전체 페이지 수
				int dataCount;  // 전체 데이터 컨텐츠 수
				
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("categoryCode", categoryCode);
				
				//카테고리 정보
				MainProduct categoryDto = Objects.requireNonNull(service.findByCategoryId(categoryCode));
				System.out.println("categoryDto: " + categoryDto);
				
				dataCount = service.dataCount(map);
				total_page = paginateUtil.pageCount(dataCount, size);
				
				current_page = Math.min(current_page, total_page);
				
				int offset = (current_page - 1) * size;
				if(offset < 0) offset = 0;
				
				map.put("offset", offset);
				map.put("size", size);
				
				List<MainProduct> popularList = service.listPopularProduct(map);
		
				response.put("popularList", popularList);			
				response.put("categoryName", categoryName);		
	            response.put("categoryCode", categoryCode);
	            response.put("page", current_page);
	            response.put("dataCount", dataCount);
	            response.put("size", size);
	            response.put("total_page", total_page);
				
			} catch (NullPointerException e) {
				log.info("main NullPointerException : ", e  );
				return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
			} catch (Exception e) {
				log.info("main Exception : ", e  );
			    return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
			}
			return ResponseEntity.ok(response);
			
		}
		
		
		// 추천작품 별 조회
				@ResponseBody
				@GetMapping("byRecommendWorks") 
				public ResponseEntity<Map<String, Object>> byRecommendWorks(
						@RequestParam(name = "categoryName") String categoryName,
						@RequestParam(name = "page", defaultValue = "1") int current_page, 
						HttpServletRequest req ) throws Exception{
					
					System.out.println("categoryName : " + categoryName);
					
					 Map<String, Object> response = new HashMap<>();
					
					try {
						// 받아온 카테고리명을 카테고리코드로 변환
				        if (!categoryMap.containsKey(categoryName)) {
				            return ResponseEntity.badRequest().body(Map.of("error", "유효하지 않은 카테고리명입니다."));
				        }

					    int categoryCode = categoryMap.get(categoryName); // 카테고리명을 카테고리코드로 변환
						int size = 15;  // 페이지 당 포함 컨텐츠 수
						int total_page; // 전체 페이지 수
						int dataCount;  // 전체 데이터 컨텐츠 수
						
						Map<String, Object> map = new HashMap<String, Object>();
						map.put("categoryCode", categoryCode);
						
						//카테고리 정보
						MainProduct categoryDto = Objects.requireNonNull(service.findByCategoryId(categoryCode));
						System.out.println("categoryDto: " + categoryDto);
						
						dataCount = service.dataCount(map);
						total_page = paginateUtil.pageCount(dataCount, size);
						
						current_page = Math.min(current_page, total_page);
						
						int offset = (current_page - 1) * size;
						if(offset < 0) offset = 0;
						
						map.put("offset", offset);
						map.put("size", size);
						
						List<MainProduct> recommendList = service.listRecommendProduct(map);
				
						response.put("recommendList", recommendList);			
						response.put("categoryName", categoryName);		
			            response.put("categoryCode", categoryCode);
			            response.put("page", current_page);
			            response.put("dataCount", dataCount);
			            response.put("size", size);
			            response.put("total_page", total_page);
						
					} catch (NullPointerException e) {
						log.info("main NullPointerException : ", e  );
						return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
					} catch (Exception e) {
						log.info("main Exception : ", e  );
					    return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
					}
					return ResponseEntity.ok(response);
					
				}

	// 상품상세보기 초화면 조회
	@GetMapping("{productCode}")
	public String productDetail(@PathVariable("productCode") long productCode,
			Model model, HttpSession session, ViewProduct viewProduct) throws Exception{
		
		try {
			SessionInfo member = (SessionInfo) session.getAttribute("member");
			if(member != null) {
				viewProduct.setMemberIdx(member.getMemberIdx());
				viewProduct.setProductCode(productCode);
				viewService.insertOrUpdateRecentViewed(viewProduct);
			}

			//상품
			MainProduct dto = Objects.requireNonNull(service.findById(productCode));
	
			
			//상품가격 1000단위 쉼표
		    NumberFormat formatter = NumberFormat.getInstance(Locale.KOREA);
		    String fmdPrice = formatter.format(dto.getPrice());
		    String fmdSalePrice= formatter.format(dto.getSalePrice());
		    
		    //추가 이미지
		    List<MainProduct> listFile = service.listMainProductFile(productCode);

		    
		    // 추가 이미지 리스트 확인
		    System.out.println("listFile size: " + (listFile != null ? listFile.size() : "null"));

		    if (listFile != null) {
		        for (MainProduct file : listFile) {
		            System.out.println("File: " + file.getImageFileName());
		        }
		    }
		    
			// 옵션1/옵션2 옵션명
			List<ProductManage> listOption = productManageServcie.listProductOption(productCode);

			// 옵션 count 설정
			dto.setOptionCount(listOption.size());
			
			// 옵션1/옵션2 상세 옵션
			List<ProductManage> listOptionDetail = null;
			List<ProductManage> listOptionDetail2 = null;
			if(listOption.size() > 0) {
				dto.setOption_code(listOption.get(0).getOption_code());
				dto.setOption_name(listOption.get(0).getOption_name());
				listOptionDetail = productManageServcie.listOptionDetail(listOption.get(0).getOption_code());
			}
			if(listOption.size() > 1) {
				dto.setOption_code2(listOption.get(1).getOption_code());
				dto.setOption_name2(listOption.get(1).getOption_name());
				listOptionDetail2 = productManageServcie.listOptionDetail(listOption.get(1).getOption_code());
			}
		    
		    model.addAttribute("dto", dto);
		    model.addAttribute("fmdPrice", fmdPrice);
		    model.addAttribute("fmdSalePrice", fmdSalePrice);
		    model.addAttribute("listFile", listFile);
		    model.addAttribute("listOption", listOption);
			model.addAttribute("listOptionDetail", listOptionDetail);
			model.addAttribute("listOptionDetail2", listOptionDetail2);
		    
		    return "product/detail";
		    
		} catch (NullPointerException e) {
			log.info("detailRequest NullPointerException : ", e  );
		} catch (Exception e) {
			log.info("detailRequest Exception : ", e  );
			
		}
		return "redirect:/product/main";
	}
	
	// 상품상세페이지 하단 작품정보, 후기글 조회
    @ResponseBody
	@GetMapping("tabContent/{productCode}")
	public  ResponseEntity<Map<String, Object>> getTabContent(
			@RequestParam("tab") String tab, 
			@PathVariable("productCode") long productCode,
			Model model) {
    	Map<String, Object> map = new HashMap<>();

		try {
			if(tab.equals(".product-detail-info")) {
				
				MainProduct dto = service.findById(productCode);
				
				 if (dto == null) {
					 map.put("error", "상품 정보를 찾을 수 없습니다.");
					 return ResponseEntity.status(HttpStatus.NOT_FOUND).body(map);
		            }
				 
				 map.put("dto", dto);

			}else if (tab.equals(".product-review")) {
				List<MainProduct> listReview = service.listMainProductReview(productCode);
				
				if (listReview == null) {
					 map.put("error", "상품 정보를 찾을 수 없습니다.");
					 return ResponseEntity.status(HttpStatus.NOT_FOUND).body(map);
		            }
				map.put("listReview", listReview);
	        }
			
			for (Map.Entry<String, Object> entry : map.entrySet()) {
			    System.out.println("Key: " + entry.getKey() + ", Value: " + entry.getValue());
			}
			return  ResponseEntity.ok(map);
			
		} catch (Exception e) {
			log.info("getTabContent Exception : ", e  );
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(map);
	}
    
    // 후기글 신고하기
    @PostMapping("reveiwReport")
	public ResponseEntity productReviewReport(
			@RequestParam(name = "reviewNum") String review_num,
			@RequestParam(name = "categoryName") String category_name,
			@RequestParam(name = "content") String content,
			HttpSession session) throws Exception{
    	
    	Long memberIdx = getMemberIdx(session);
	    if (memberIdx == null) {
	    	return ResponseEntity.badRequest().body(Map.of("error", "유효하지 않은 세션입니다."));
	    }
	    Map<String, Object> response = new HashMap<>();
	    
		try {
			System.out.println("memberIdx : " + memberIdx);
		    System.out.println("review_num : " + review_num);
		    System.out.println("category_name : " + category_name);
		    System.out.println("content : " + content);
		    
			// 받아온 카테고리명을 카테고리번호로 변환
			 Map<String, Integer> categoryMap = Map.of(
		                "spam"      , 1,  // 스팸 또는 광고
		                "offensive" , 2,  // 부적절한 콘텐츠
		                "copyright" , 3,  // 저작권 침해
		                "other"     , 4   // 기타
		                );

	        if (!categoryMap.containsKey(category_name)) {
	            return ResponseEntity.badRequest().body(Map.of("error", "유효하지 않은 카테고리명입니다."));
	        }

		    int categoryNum = categoryMap.get(category_name); // 카테고리명을 카테고리번호로 변환 - 신고하기/문의하기 테이블 카테고리 정보
		    System.out.println("categoryNum : " + categoryNum);
		    
		    Map<String, Object> params = new HashMap<>();
		    params.put("memberIdx", memberIdx);
		    params.put("review_num", review_num);
		    params.put("categoryNum", categoryNum);
		    params.put("content", content);
		    
		    service.insertReveiwReport(params); // 후기글 신고등록
		    
		} catch (NullPointerException e) {
			log.info("detailRequest NullPointerException : ", e  );
			return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		} catch (Exception e) {
			log.info("detailRequest Exception : ", e  );
			return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		}
		return ResponseEntity.ok("신고가 성공적으로 접수 되었습니다");
	}
    
 // 작품 신고하기
    @PostMapping("productReport")
	public ResponseEntity productReviewReport(
			@RequestParam(name = "productCode") Long productCode,
			@RequestParam(name = "categoryName") String category_name, //사유옵션
			@RequestParam(name = "content") String content,
			HttpSession session) throws Exception{
    	
    	Long memberIdx = getMemberIdx(session);
	    if (memberIdx == null) {
	    	return ResponseEntity.badRequest().body(Map.of("error", "유효하지 않은 세션입니다."));
	    }
	    
		try {
			System.out.println("memberIdx : " + memberIdx);
		    System.out.println("productCode : " + productCode);
		    System.out.println("category_name : " + category_name);
		    System.out.println("content : " + content);
		    
			// 받아온 카테고리명을 카테고리번호로 변환
			 Map<String, Integer> categoryMap = Map.of(
		                "spam"      , 1,  // 스팸 또는 광고
		                "offensive" , 2,  // 부적절한 콘텐츠
		                "copyright" , 3,  // 저작권 침해
		                "other"     , 4   // 기타
		                );

	        if (!categoryMap.containsKey(category_name)) {
	            return ResponseEntity.badRequest().body(Map.of("error", "유효하지 않은 카테고리명입니다."));
	        }

		    int categoryNum = categoryMap.get(category_name); // 카테고리명을 카테고리번호로 변환 - 신고하기/문의하기 테이블 카테고리 정보
		    System.out.println("categoryNum : " + categoryNum);
		    
		    Map<String, Object> params = new HashMap<>();
		    params.put("memberIdx", memberIdx);
		    params.put("productCode", productCode);
		    params.put("categoryNum", categoryNum);
		    params.put("content", content);
		    
		    service.insertProductReport(params); // 후기글 신고등록
		    
		} catch (NullPointerException e) {
			log.info("detailRequest NullPointerException : ", e  );
			return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		} catch (Exception e) {
			log.info("detailRequest Exception : ", e  );
			return ResponseEntity.internalServerError().body(Map.of("error", "서버 오류가 발생했습니다."));
		}
		return ResponseEntity.ok("신고가 성공적으로 접수 되었습니다");
	}
    
    // Session 에서 회원코드 반환
    private static Long getMemberIdx(HttpSession session) {
      SessionInfo member = (SessionInfo) session.getAttribute("member");
      return member.getMemberIdx();
    }
      
}
