package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.model.Notice;
import com.sp.app.mapper.NoticeMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor

public class NoticeServiceImpl implements NoticeService{
	
	private final NoticeMapper mapper;

	@Override
	public List<Notice> getListOfFaq(Map<String, Object> map) {
		List<Notice> list = null;
		try {
			list = mapper.getListOfFaq(map);
		} catch (Exception e) {
			log.info("================getListOfFaq", e);
		}
		return list;
	}

	@Override
	public List<String> getCategory() {
		List<String> list = null;
		try {
			list = mapper.getCategory();
		} catch (Exception e) {
			log.info("================getCategory", e);
		}
		return list;
	}

	@Override
	public int DataCountFaq(Map<String, Object> map) {
		int result = 0 ;
		try {
			mapper.DataCountFaq(map);
		} catch (Exception e) {
			log.info("===========Datacount : ", e);
		}
		return result;
	}

	@Override
	public List<Notice> getListOfNotice(Map<String, Object> map) {
		return null;
	}

	@Override
	public int DataCountNotice(Map<String, Object> map) {
		return 0;
	}
	
}
