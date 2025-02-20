package com.sp.app.artist.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.artist.model.ProductManage;
@Service
public interface ProductManageService {
	public ProductManage findByCategoryId(int CategoryCode);
	public List<ProductManage> listMainCategory();
	public List<ProductManage> listSubCategory(long parentNum);

}
