package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.MainProduct;
@Mapper
public interface MainProductMapper {
	public int dataCount(Map<String, Object> map);
	public List<MainProduct> listMainProduct(Map<String, Object> map); // 카테고리별 작품리스트 조회
	public List<MainProduct> listPopularProduct(Map<String, Object> map); // 인기작품별 작품리스트 조회
	
	public MainProduct findById(long productCode);
	public List<MainProduct> listMainProductFile(long productCode);
	public MainProduct findByCategoryId(int CategoryCode);
	public List<MainProduct> listMainProductReview(long productCode); 
	public void insertReveiwReport(Map<String, Object> params);


}
