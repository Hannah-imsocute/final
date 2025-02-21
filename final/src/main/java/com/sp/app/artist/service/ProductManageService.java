package com.sp.app.artist.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.artist.model.ProductManage;
@Service
public interface ProductManageService {
	public ProductManage findByCategoryId(int CategoryCode);
	public List<ProductManage> listMainCategory();
	public List<ProductManage> listSubCategory(long parentNum);

	//작품 등록할때 작품 정보 인서트
    public void insertProduct(ProductManage product);
    
    //옵션정보
    public List<ProductManage> listProductOption(long productCode);
	public List<ProductManage> listOptionDetail(long option_code);
    
}
