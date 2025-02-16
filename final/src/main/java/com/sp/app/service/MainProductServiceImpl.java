package com.sp.app.service;

import java.text.NumberFormat;
import java.util.List;
import java.util.Locale;
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
			
			int discountPrice; //할인되는 가격
			for(MainProduct dto : list) {
				discountPrice = 0;
				if(dto.getDiscount()>0) {
					discountPrice = (int)(dto.getPrice() * dto.getDiscount()/100);
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

		MainProduct dto = null;
		int discountPrice ; //할인되는 가격
		
		try {
			dto = mapper.findById(productCode);
			discountPrice = 0; //할인되는 가격
			if(dto.getDiscount()>0) {
				discountPrice = (int)(dto.getPrice() * (dto.getDiscount()/100));
			}
			dto.setSalePrice(dto.getPrice()-discountPrice);

			
		} catch (Exception e) {
			log.info("findById : " ,e);
		}
		return dto;
	}

	@Override
	public List<MainProduct> listMainProductFile(long productCode) {
		List<MainProduct> list = null;
		
		try {
			list = mapper.listMainProductFile(productCode);
			
		} catch (Exception e) {
			log.info("listMainProductFile : ", e);
		}

		return list;
	}

	@Override
	public MainProduct findByCategoryId(int categoryCode) {
		MainProduct dto = new MainProduct();
		
		try {
			dto = mapper.findByCategoryId(categoryCode);
		
		} catch (Exception e) {
			log.info("MainProductServiceImpl : ", e  );
		}
		return dto;
	}

	@Override
	public List<MainProduct> listMainProductReview(long productCode) {
		List<MainProduct> list = null;
		
		try {
			list = mapper.listMainProductReview(productCode);
			
		} catch (Exception e) {
			log.info("listMainProductReview : " , e);
		}
		return list;
	}

	@Override
	public void insertReveiwReport(Map<String, Object> params) {
		try {
			mapper.insertReveiwReport(params);
		}catch(Exception e) {
			log.info("insertReveiwReport : ", e  );
		}
	}


}
