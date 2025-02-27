package com.sp.app.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.Information;
import com.sp.app.admin.model.Notice;

public interface NoticeService {
	// 필요한 기능
	// faq 리스트 불러오기(검색있음), 문의사항 리스트불러오기, 공지사항 리스트 불러오기
	// data개수 각각 몇개인지 불러오기

	public List<Notice> getListOfFaq(Map<String, Object> map);

	public int DataCountFaq(Map<String, Object> map);

	public List<Notice> getListOfNotice(Map<String, Object> map);

	public int DataCountNotice(Map<String, Object> map);

	public List<String> getCategory();

	public Notice findByIdOfNotice(long num);

	public void insertInquiry(Information dto) throws SQLException;

	public int dataCountOfInquiry(String kwd);

	public List<Information> getListOfInquiry(Map<String, Object> map);
}
