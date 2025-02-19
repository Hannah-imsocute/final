package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

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
		List<Notice> list = null;
		try {
			list = mapper.getListOfNotice(map);
		} catch (Exception e) {
			log.info("=================getListOfNotice", e);
		}
		return list;
	}

	@Override
	public int DataCountNotice(Map<String, Object> map) {
		int result = 0;
		try {
			result = mapper.DataCountNotice(map);
		} catch (Exception e) {
			log.info("====================DataCountNotice", e);
		}
		return result;
	}

	@Override
	public Notice findByIdOfNotice(long num) {
		Notice dto = null;
		try {
			dto = Objects.requireNonNull(mapper.findByIdOfNotice(num));
		} catch (Exception e) {
			log.info("===================findById : ", e);
		}
		return dto;
	}
}
