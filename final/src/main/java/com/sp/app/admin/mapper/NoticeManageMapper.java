package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.Information;
import com.sp.app.admin.model.Notice;

@Mapper
public interface NoticeManageMapper {
	
	public void insertNotice(Map<String, Object> map) throws SQLException;
	public Notice findById(long num);
	public int dataCount(String kwd);
	public List<Notice> getList(Map<String, Object> map);
	
	
	public int dataCountOfInfo(String kwd);
	public List<Information> getListOfInfo(Map<String, Object> map);
	public void updateInfo(Information info) throws SQLException;
}
