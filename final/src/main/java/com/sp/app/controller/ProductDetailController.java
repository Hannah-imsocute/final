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

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.MainProduct;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MainProductService;
import com.sp.app.service.ProductDetailService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/product/*")
public class ProductDetailController {
	private final ProductDetailService service;
	private final PaginateUtil paginateUtil;

	// 카테고리명 카테고리코드로 변환
    public static final Map<String, Integer> categoryMap = Map.ofEntries(
            new AbstractMap.SimpleEntry<>("bakery"             ,  1),  // 베이커리/전통간식
            new AbstractMap.SimpleEntry<>("beverage"           ,  2),  // 음료/주류
            new AbstractMap.SimpleEntry<>("dish"               ,  3),  // 요리/간편식
            new AbstractMap.SimpleEntry<>("nongsusan"          ,  4),  // 농수산품
            new AbstractMap.SimpleEntry<>("clothing"           ,  5),  // 의류
            new AbstractMap.SimpleEntry<>("jewelry"            ,  6),  // 주얼리
            new AbstractMap.SimpleEntry<>("fashion-accessory"  ,  7),  // 패션잡화
            new AbstractMap.SimpleEntry<>("camping"            ,  8),  // 캠핑
            new AbstractMap.SimpleEntry<>("furniture"          ,  9),  // 가구
            new AbstractMap.SimpleEntry<>("home-decor"         , 10),  // 홈데코
            new AbstractMap.SimpleEntry<>("kitchenware"        , 11),  // 주방용품
            new AbstractMap.SimpleEntry<>("bathroom"           , 12),  // 욕실용품
            new AbstractMap.SimpleEntry<>("case"               , 13),  // 케이스
            new AbstractMap.SimpleEntry<>("stationery"         , 14),  // 문구용품
            new AbstractMap.SimpleEntry<>("party-supplies"     , 15),  // 파티용품
            new AbstractMap.SimpleEntry<>("car-accessory"      , 16),  // 차량용품
            new AbstractMap.SimpleEntry<>("skincare"           , 17),  	// 스킨케어
            new AbstractMap.SimpleEntry<>("hair-body-cleansing", 18),  // 헤어/바디/클렌징
            new AbstractMap.SimpleEntry<>("perfume"            , 19),  // 향수
            new AbstractMap.SimpleEntry<>("makeup"             , 20)   // 메이크업
        );
	
    
    
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
