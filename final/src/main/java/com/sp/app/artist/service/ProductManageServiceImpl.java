package com.sp.app.artist.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.artist.mapper.ProductManageMapper;
import com.sp.app.artist.model.ProductManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ProductManageServiceImpl implements ProductManageService{
	public final ProductManageMapper mapper;
	
	@Override
	public ProductManage findByCategoryId(int CategoryCode) {
		ProductManage dto = null;
		try {
			dto = mapper.findByCategoryId(CategoryCode);
	
		} catch (Exception e) {
			log.info("findByCategoryId : ", e);
		}
		return dto;
	}

	@Override
	public List<ProductManage> listMainCategory() {
		List<ProductManage> list = null;
		
		try {
			list = mapper.listMainCategory();
		} catch (Exception e) {
			log.info("listCategory : ", e);
		}
				
		return list;
	}

	@Override
	public List<ProductManage> listSubCategory(long parentCategoryCode) {
		List<ProductManage> list = null;
		
		try {
			list = mapper.listSubCategory(parentCategoryCode);
		} catch (Exception e) {
			log.info("listSubCategory : ", e);
		}
		return list;
	}

    @Override
    public void insertProduct(ProductManage product) {
        try {
            mapper.insertProduct(product);
        } catch(Exception e) {
            log.error("insertProduct error: ", e);
            throw e; // 필요 시 예외처리(롤백 등) 수행
        }
    }

}
