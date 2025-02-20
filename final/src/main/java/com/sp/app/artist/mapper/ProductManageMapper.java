package com.sp.app.artist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.artist.model.ProductManage;
@Mapper
public interface ProductManageMapper {
	public ProductManage findByCategoryId(int CategoryCode);
	public List<ProductManage> listMainCategory();
	public List<ProductManage> listSubCategory(long parentNum);

}
