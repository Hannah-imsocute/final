package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MainProductMapper;
import com.sp.app.model.MainProduct;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MainProductServiceImpl implements MainProductService{
	private final MainProductMapper mapper;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}
	
	@Override
	public List<MainProduct> listMainProduct(Map<String, Object> map) {
		List<MainProduct> list = null;
		
		try {
			list = mapper.listMainProduct(map);
			
			int discountPrice;
			for(MainProduct dto : list) {
				discountPrice = 0;
				if(dto.getDiscount()>0) {
					discountPrice = (int)(dto.getPrice() * dto.getDiscount());
				}
				dto.setSalePrice(dto.getPrice() - discountPrice);
			}
		} catch (Exception e) {
			log.info("listMainProduct : ", e);
		}
		return list;
	}

	@Override
	public MainProduct findById(long productCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MainProduct> listMainProductFile(long productCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MainProduct findByCategoryId(long CategoryCode) {
		
		return null;
	}

	@Override
	public List<MainProduct> listAllCategory() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MainProduct> listCategory() {
		return null;
	}

	@Override
	public List<MainProduct> listSubCategory(long parentCategoryCode) {
		// TODO Auto-generated method stub
		return null;
	}

}
