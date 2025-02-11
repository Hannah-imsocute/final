
package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

//메인페이지에 카테고리별, 추천작품, 인기작품별 작품 dto
@Getter
@Setter
@NoArgsConstructor
public class MainProduct {
	private long productCode;
	private long brandCode;
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
	private String categoryName;
	private String thumbnail;
	private int soldOut; //품절여부
	
	//상품 카테고리
	private String name; //상품카테고리 이름
	private int ParentCategoryCode; //상품 상위카테고리
	

}