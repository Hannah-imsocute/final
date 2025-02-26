package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Information;
import com.sp.app.admin.model.Notice;

public interface NoticeManageService {
	
	public void insertNotice(Map<String, Object> map) throws Exception;
	public Notice findById(long num);
	public int dataCount(String kwd);
	public List<Notice> getList(int offset, int size, String kwd);

	
	public int dataCountOfInfo(String kwd);
	public List<Information> getListOfInfo(int offset, int size, String kwd);
}
