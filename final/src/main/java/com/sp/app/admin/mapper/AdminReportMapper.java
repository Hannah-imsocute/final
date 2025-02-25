package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Report;

@Mapper
public interface AdminReportMapper {
	
	public int dataCountOfProduct(Map<String, Object> map);
	public List<Report> getListOfProduct(Map<String, Object> map);
	
	public List<Report> getCategoryOfReport();
	
	public int dataCountOfReviews(Map<String, Object> map);
	public List<Report> getListOfReviews(Map<String, Object> map);
	
	public Report findByIdOfProduct(long num);
	public Report findByIdOfReview(long num);
}
