package com.sp.app.artist.mapper;

import java.sql.SQLException;
import java.util.List;

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
    public void insertProductFile(ProductManage dto) ;
    
    //옵션정보
    public List<ProductManage> listProductOption(long productCode) ;
	public List<ProductManage> listOptionDetail(long option_code) ;
    
    
}
