package com.sp.app.artist.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.artist.model.ProductManage;
@Service
public interface ProductManageService {
	public ProductManage findByCategoryId(int CategoryCode);
	public List<ProductManage> listMainCategory();
	public List<ProductManage> listSubCategory(long parentNum);
	
    /**
     * 신규 제품(작품) 정보를 DB에 등록하는 메서드.
     * @param product 등록할 제품 정보
     */
    public void insertProduct(ProductManage product);
}
