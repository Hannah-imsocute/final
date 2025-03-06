package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.StatsListMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class StatsListServiceImpl implements StatsListService {
	private final StatsListMapper mapper;
	

	@Override
	public List<Map<String, Object>> listAgeSection() {
		List<Map<String, Object>> list = null;
		
		try {
			list = mapper.listAgeSection();
		} catch (Exception e) {
			log.info("listAgeSection : ", e);
		}
		
		return list;
	}


	@Override
	public List<Map<String, Object>> memberStatus() {
		List<Map<String, Object>> list = null;
		
		try {
			list = mapper.memberStatus();
		} catch (Exception e) {
			log.info("memberStatus");
		}
		return list;
	}



}
