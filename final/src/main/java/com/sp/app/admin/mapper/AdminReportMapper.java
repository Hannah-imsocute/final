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
}
