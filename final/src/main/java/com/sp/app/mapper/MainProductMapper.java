package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.MainProduct;
@Mapper
public interface MainProductMapper {
	public int totalDataCount(Map<String, Object> map);
	public List<MainProduct> listCategoryMainProduct(Map<String, Object> map); //카테고리별 작품 리스트 초화면(메인)
	public List<MainProduct> listPopularMainProduct(Map<String, Object> map); //카테고리별 작품 리스트 초화면(메인)
	public List<MainProduct> listRecommendMainProduct(Map<String, Object> map); //카테고리별 작품 리스트 초화면(메인)
	
	public int dataCount(Map<String, Object> map); //카테고리별 작품 개수
	public List<MainProduct> listMainProduct(Map<String, Object> map); // 카테고리별 작품리스트 조회
	
	public List<MainProduct> listCategoryProduct(Map<String, Object> map); // 카테고리별 작품리스트 조회
	public List<MainProduct> listPopularProduct(Map<String, Object> map); // 인기작품별 작품리스트 조회
	public List<MainProduct> listRecommendProduct(Map<String, Object> map); // 추천작품별 작품리스트 조회
	
	public MainProduct findById(long productCode);
	public List<MainProduct> listMainProductFile(long productCode);
	public MainProduct findByCategoryId(int CategoryCode);
	public List<MainProduct> listMainProductReview(long productCode); 
	public List<MainProduct> listMainBannerItem(); 
	public void insertReveiwReport(Map<String, Object> params);

	public void insertProductReport(Map<String, Object> params); //작품 신고


}
