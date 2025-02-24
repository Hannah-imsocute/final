package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

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

}
