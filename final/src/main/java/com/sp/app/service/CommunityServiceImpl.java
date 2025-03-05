package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.CommunityMapper;
import com.sp.app.model.Community;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService{
	private final CommunityMapper mapper;

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Community findById(long num) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Community> listCommunity(Map<String, Object> map) throws Exception {
		List<Community> list = null;

		try {
			list = mapper.listCommunity(map);
		} catch (Exception e) {
			log.info("listCommunity : ", e);
		}
		return list;
	}

	@Override
	public void insertCommunity(Community dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateCommunity(Community dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCommunity(long num, String uploadPath, String memberIdx, String AUTHORITY) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Community findByPrev(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Community findByNext(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	
}
