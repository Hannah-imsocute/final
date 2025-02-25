package com.sp.app.admin.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.NoticeManageMapper;
import com.sp.app.admin.model.Information;
import com.sp.app.admin.model.Notice;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class NoticeManageServiceImpl implements NoticeManageService {
	
	private final NoticeManageMapper mapper;

	@Override
	public void insertNotice(Map<String, Object> map) throws Exception {
		try {
			mapper.insertNotice(map);
		} catch (Exception e) {
			log.info("========================insertNotice", e);
		}
	}

	@Override
	public int dataCount() {
		int result = 0;
		try {
			result = mapper.dataCount();
		} catch (Exception e) {
			log.info("==============dataCount : ", e);
		}
		return result;
	}

	@Override
	public List<Notice> getList(int offset, int size) {
		List<Notice> list = null;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("offset", offset);
			map.put("size", size);
			
			list = mapper.getList(map);
			
		} catch (Exception e) {
			log.info("============getList", e);
		}
		return list;
	}

	@Override
	public Notice findById(long num) {
		Notice dto = null;
		try {
			dto = mapper.findById(num);
			
		} catch (Exception e) {
			log.info("===============findById : ", e);
		}
		return dto;
	}

	
	
	@Override
	public void insertInfo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int dataCountOfInfo() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Information> getListOfInfo(int offset, int size) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
}
