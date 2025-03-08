package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.Community;
import com.sp.app.model.MainProduct;
@Mapper
public interface CommunityMapper {
	public int dataCount(Map<String, Object> map) throws SQLException;
	public Community findById(long num) throws SQLException;
	public List<Community> listCommunity(Map<String, Object> map) throws SQLException;
	public void insertCommunity(Community dto, String uploadPath) throws SQLException;
	public void insertCommunityImage(Community dto, String uploadPath) throws SQLException;
	public void updateCommunity(Community dto, String uploadPath) throws SQLException;
	public void deleteCommunity(long num, String uploadPath, String memberIdx, String AUTHORITY) throws SQLException;

	public void updateHitCount(long num) throws SQLException;
	
	public Community findByPrev(Map<String, Object> map) throws SQLException;
	public Community findByNext(Map<String, Object> map) throws SQLException;

	public boolean deleteUploadFile(String uploadPath, String filename) throws SQLException;



}
