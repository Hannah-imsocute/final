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
			
			Notice dto = (Notice) map.get("dto");
			int yesOrno = dto.getFixed() == 1 ? 1 : 0 ;
			map.put("yesOrno", yesOrno);
			mapper.insertNotice(map);
		} catch (Exception e) {
			log.info("========================insertNotice", e);
		}
	}

	@Override
	public int dataCount(String kwd) {
		int result = 0;
		try {
			result = mapper.dataCount(kwd);
		} catch (Exception e) {
			log.info("==============dataCount : ", e);
		}
		return result;
	}

	@Override
	public List<Notice> getList(int offset, int size, String kwd) {
		List<Notice> list = null;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("offset", offset);
			map.put("size", size);
			map.put("kwd", kwd);
			
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
	public int dataCountOfInfo(String kwd) {
		int result = 0;
		try {
			result = mapper.dataCountOfInfo(kwd);
		} catch (Exception e) {
			log.info("===============dataCountInfo", e);
		}
		return result;
	}

	
	@Override
	public List<Information> getListOfInfo(int offset, int size, String kwd) {
		List<Information> list = null;
		try {
			
			Map<String, Object> map = new HashMap<>();
			
			map.put("offset", offset);
			map.put("size", size);
			map.put("kwd", kwd);
			
			list = mapper.getListOfInfo(map);
			
		} catch (Exception e) {
			log.info("==================getListOfInfo", e);
		}
		return list;
	}

	@Override
	public Information findByIdOfInfo(long num) {
		Information dto = null;
		try {
			dto = mapper.findByIdOfInfo(num);
		} catch (Exception e) {
			log.info("=================findByIdOfInfo", e);
		}
		return dto;
	}

	@Override
	public void updateInfo(long memberidx, long num, String answer) throws Exception {
		Map<String, Object> map = new HashMap<>();
		
		try {
		
			map.put("adminidx", memberidx);
			map.put("answer", answer);
			map.put("num", num);
			
			mapper.updateInfo(map);
			
		} catch (Exception e) {
			log.info("====================updateInfo :", e);
		}
		
	}

	

	
	
	
}
