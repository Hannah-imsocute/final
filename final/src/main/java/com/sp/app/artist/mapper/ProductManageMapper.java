package com.sp.app.artist.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.artist.model.ProductManage;

@Mapper
public interface ProductManageMapper {

	public ProductManage findByCategoryId(int CategoryCode);
	public List<ProductManage> listMainCategory() ;
	public List<ProductManage> listSubCategory(long parentCategoryCode) ;
 
	//작품 등록할때 작품 정보 인서트
	public long seq_product();
    public void insertProduct(ProductManage product) ;
    public void insertProductImage(ProductManage dto) ;
    
    //옵션 등록
	public long seq_productOption();
	public void insertProductOption(ProductManage dto);
	
	//옵션상세 등록
	public long seq_productOptionDetail();
	public void insertProductOptionDetail(ProductManage dto);
    
    //옵션정보
    public List<ProductManage> listProductOption(long productCode) ;
	public List<ProductManage> listOptionDetail(long option_code) ;
	
    public List<ProductManage> listProduct(Map<String, Object> map) ;
	
    
    
}
