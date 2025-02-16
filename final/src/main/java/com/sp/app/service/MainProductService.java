package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.MainProduct;

public interface MainProductService {
	public int dataCount(Map<String, Object> map);
	public List<MainProduct> listMainProduct(Map<String, Object> map);
	
	public MainProduct findById(long productCode);
	public List<MainProduct> listMainProductFile(long productCode);
	public MainProduct findByCategoryId(int CategoryCode);
	public List<MainProduct> listMainProductReview(long productCode);
	public void insertReveiwReport(Map<String, Object> params);
	

}
