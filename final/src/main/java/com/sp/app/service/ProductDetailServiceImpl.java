package com.sp.app.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.ProductDetailMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ProductDetailServiceImpl implements ProductDetailService{
	private final ProductDetailMapper mapper;

	@Override
	public void insertProductReport(Map<String, Object> params) {
		try {
			mapper.insertProductReport(params);
		}catch(Exception e) {
			log.info("insertProductReport : ", e  );
		}
	
		
	}

}