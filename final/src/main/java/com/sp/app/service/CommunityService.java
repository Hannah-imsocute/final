package com.sp.app.service;

import java.util.List;
import java.util.Map;

import com.sp.app.model.Community;


public interface CommunityService {

	public int dataCount(Map<String, Object> map) throws Exception;
	public Community findById(long num) throws Exception;
	public List<Community> listCommunity(Map<String, Object> map) throws Exception;
	public void insertCommunity(Community dto) throws Exception;
	public void insertCommunityImage(Community dto, String uploadPath) throws Exception;
	
	public void updateCommunity(Community dto, String uploadPath) throws Exception;
	public void deleteCommunity(long num, String uploadPath, String memberIdx, String AUTHORITY) throws Exception;

	public void updateHitCount(long num) throws Exception;
	
	public Community findByPrev(Map<String, Object> map) throws Exception;
	public Community findByNext(Map<String, Object> map) throws Exception;

	public boolean deleteUploadFile(String uploadPath, String filename) throws Exception;


}
