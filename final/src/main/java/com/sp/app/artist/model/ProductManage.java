
package com.sp.app.artist.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//메인페이지에 카테고리별, 추천작품, 인기작품별 작품 dto
@Getter
@Setter
@NoArgsConstructor
public class ProductManage {
		private long memberIdx; // user session id
	
		private long productCode;
		private long brand_code;
		private String brandName;
		private String item; //작품 명
		private int price;
		private double discount;
		private int salePrice;
		private int addOptions; //광고여부
		private String describe;
		private String upload;  //upload한 날짜 
		private String modified; //수정한 날짜 
		private int categoryCode;
		private String thumbnail;
		private MultipartFile thumbnailFile; //파일 수정에서 기존 파일 삭제시 MultipartFile 필요
		private int blind; //작품 차단여부
		
		private String parentCategoryName;
		private String categoryName;
		
		//상품 카테고리
		private String name; //상품카테고리 이름
		private int parentCategoryCode; //상품 상위카테고리

		//상품 추가 이미지
		private long image_code;
		private String imageFileName;
		private List<MultipartFile> addFiles;
		
		//상품 상세 수량 옵션
		private int quantity;
		
		//상품 상세 구매옵션
		private int optionCount;
		
		private long option_code;
		private String option_name;
		private long option_code2;
		private String option_name2;
		private long parent_option;
		
		private int option_price;
		
		private Long optionDetail_code;;
		private String option_value;
		private List<Long> optionDetail_codes;
		private List<String> option_values;
		
		private Long optionDetail_code2;;
		private String option_value2;
		private List<Long> optionDetail_codes2;
		private List<String> option_values2;
		
		// 수정전 옵션
		private long prevOption_code;
		private long prevOption_code2;
		
		
		
		
		//상품 별 후기
		private long review_num;
		private String nickName;
		private String content;

		private long category_num;
		
	}