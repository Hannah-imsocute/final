package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Report;

public interface AdminReportService {
	
	public int dataCountOfProduct(Map<String,Object> map);
	public List<Report> getListOfProduct(Map<String, Object> map);
	
	public List<Report> getCategoryOfReport();
}
