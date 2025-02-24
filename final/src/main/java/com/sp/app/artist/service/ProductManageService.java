package com.sp.app.artist.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.artist.model.ProductManage;
@Service
public interface ProductManageService {
	public ProductManage findByCategoryId(int CategoryCode);
	public List<ProductManage> listMainCategory();
	public List<ProductManage> listSubCategory(long parentNum);

	//작품 등록할때 작품 정보 인서트
    public void insertProduct(ProductManage dto, MultipartFile thumbnailFile, String uploadPath) throws SQLException;
    public void insertProductImage(ProductManage dto,  String uploadPath);
    
    //등록된 작품 리스트 조회
    
    public List<ProductManage> listProduct(Map<String, Object> map) ;
    
    //옵션 리스트
    public List<ProductManage> listProductOption(long productCode);
	public List<ProductManage> listOptionDetail(long option_code);
	

}
