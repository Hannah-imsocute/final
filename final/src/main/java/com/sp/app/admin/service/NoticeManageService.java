package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Information;
import com.sp.app.admin.model.Notice;

public interface NoticeManageService {
	public void insertNotice(Map<String, Object> map) throws Exception;
	
	public Notice findById(long num);
	
	public int dataCount();
	public List<Notice> getList(int offset, int size);
	
	public void insertInfo(Map<String, Object> map) throws Exception;
	public int dataCountOfInfo();
	public List<Information> getListOfInfo(int offset, int size);
}
