package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Report;

public interface AdminReportService {
	
	public int dataCountOfProduct(Map<String,Object> map);
	public List<Report> getListOfProduct(Map<String, Object> map);
	
	public List<Report> getCategoryOfReport();
	
	public int dataCountOfReviews(Map<String, Object> map);
	public List<Report> getListOfReviews(Map<String, Object> map);
	
	public Report findById(Map<String, Object> map);
	
	public void updateReport(long num, String mode, String type);
}
