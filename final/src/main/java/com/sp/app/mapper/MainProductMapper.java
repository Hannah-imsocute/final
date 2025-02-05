package com.sp.app.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.MainProduct;
@Mapper
public interface MainProductMapper {
	public int dataCount(Map<String, Object> map);
	public List<MainProduct> listMainProduct(Map<String, Object> map);
	
	public MainProduct findById(long productCode);
	public List<MainProduct> listMainProductFile(long productCode);
	public MainProduct findByCategoryId(long CategoryCode);
	
	public List<MainProduct> listAllCategory(); //전체카테고리
	public List<MainProduct> listCategory(); //카테고리
	public List<MainProduct> listSubCategory(long parentCategoryCode); //하위카테고리
	


}
