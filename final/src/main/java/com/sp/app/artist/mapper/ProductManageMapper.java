package com.sp.app.artist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.artist.model.ProductManage;
@Mapper
public interface ProductManageMapper {
	public ProductManage findByCategoryId(int CategoryCode);
	public List<ProductManage> listMainCategory();
	public List<ProductManage> listSubCategory(long parentCategoryCode);
    /**
     * 신규 제품(작품) 정보를 DB에 등록하는 메서드
     * @param product 등록할 제품 정보
     */
    public void insertProduct(ProductManage product);
}
