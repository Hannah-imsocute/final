package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ApplyManage;
import com.sp.app.admin.model.MemberManage;

@Mapper
public interface ApplyManageMapper {
	public int dataCount(Map<String, Object> map);
	public List<ApplyManage> listApply(Map<String, Object> map);
	
	public MemberManage findById(Long memberIdx);
	public MemberManage findByUserId(String userId);
	
	public void updateMember1(Map<String, Object> map) throws SQLException;
	public void updateMember2(Map<String, Object> map) throws SQLException;
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException;
	public void updateFailureCountReset(Long memberIdx) throws SQLException;
	public void deleteMember1(Map<String, Object> map) throws SQLException;
	public void deleteMember2(Map<String, Object> map) throws SQLException;
	
	public void insertMemberStatus(MemberManage dto) throws SQLException;
	public List<MemberManage> listMemberStatus(Long memberIdx);
	public MemberManage findByStatus(Long memberIdx);
	
	public List<Map<String, Object>> listAgeSection();
	
	public void updateAuthority(Map<String, Object> map) throws SQLException;
	public void deleteAuthority(Map<String, Object> map) throws SQLException;
}
