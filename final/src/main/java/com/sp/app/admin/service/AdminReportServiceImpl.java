package com.sp.app.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.AdminReportMapper;
import com.sp.app.admin.model.Report;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminReportServiceImpl implements AdminReportService{

	private final AdminReportMapper mapper;
	
	@Override
	public int dataCountOfProduct(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.dataCountOfProduct(map);
		} catch (Exception e) {
			log.info("=================dataCount : ", e);
		}
		return result;
	}

	@Override
	public List<Report> getListOfProduct(Map<String, Object> map) {
		List<Report> list = null;
		try {
			list = mapper.getListOfProduct(map);
		} catch (Exception e) {
			log.info("==================getList : ", e);
		}
		return list;
	}

	@Override
	public List<Report> getCategoryOfReport() {
		List<Report> list = null;
		try {
			list = mapper.getCategoryOfReport();
		} catch (Exception e) {
			log.info("===================getCategoryOfReport", e);
		}
		return list;
	}

	@Override
	public int dataCountOfReviews(Map<String, Object> map) {
		int result = 0 ;
		try {
			result = mapper.dataCountOfReviews(map);
		} catch (Exception e) {
			log.info("==========dataCountOfReviews", e);
		}
		return result;
	}

	@Override
	public List<Report> getListOfReviews(Map<String, Object> map) {
		List<Report> list = null;
		try {
			list = mapper.getListOfReviews(map);
		} catch (Exception e) {
			log.info("==================getListOfReviews", e);
		}
		return list;
	}

	@Override
	public Report findById(Map<String, Object> map) {
		Report dto = null;
		try {
			String mode = (String) map.get("mode");
			long num = (Long) map.get("num");
			if(mode.equals("seller")) {
				dto = mapper.findByIdOfProduct(num);
			}else {
				dto = mapper.findByIdOfReview(num);
			}
		} catch (Exception e) {
			log.info("===================findById : ", e);
		}
		return dto;
	}

	@Transactional
	@Override
	public void updateReport(long num, String mode, String type) {
		Map<String, Object> map = new HashMap<>();
		try {
			map.put("type", type);
			map.put("mode", mode);
			map.put("num", num);
			
			mapper.updateProcess(map);
			
			if(type.equals("blind")) {
				Report dto = findById(map);
				updateblind(type, dto);
			}
			
		} catch (Exception e) {
			log.info("=============updateReport", e);
		}
	}
	
	public void updateblind(String type, Report dto) {
		
		if(type.equals("seller")) {
			mapper.updateBlindOfProduct(dto.getProductcode());
		}else {
			mapper.updateBlindOfReview(dto.getReview_num());
		}
	}

}
