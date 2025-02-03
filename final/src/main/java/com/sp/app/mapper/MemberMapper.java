package com.sp.app.mapper;

import com.sp.app.model.Member;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.Map;

@Mapper
public interface MemberMapper {
	public Member loginMember(String userId);
	public void updateLastLogin(String userId) throws SQLException;
	
	public void insertMember1(Member dto) throws SQLException;
	public void insertMember2(Member dto) throws SQLException;
	public void insertMember12(Member dto) throws SQLException;
	
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException;
	public void updateMemberLevel(Map<String, Object> map) throws SQLException;
	public void updateMember1(Member dto) throws SQLException;
	public void updateMember2(Member dto) throws SQLException;
	
	public Member findById(String userId);
	public Member findByMemberIdx(long memberIdx);
	
	public void deleteMember1(Map<String, Object> map) throws SQLException;
	public void deleteMember2(Map<String, Object> map) throws SQLException;
}
