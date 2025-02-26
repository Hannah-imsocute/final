package com.sp.app.service;

import com.sp.app.model.Member;
import com.sp.app.model.Seller;
import com.sp.app.model.ShippingInfo;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface MemberService {
	
	// 회원가입 insert 
	public void insertMember(Member dto) throws Exception;
	
	// seller email 검증 
	public boolean checkOfSeller(String email);
	
	// seller insert 진행 
	public void insertAllOfSeller(Seller seller) throws Exception;
	
	
	public void updateLastLogin(String userId) throws Exception;
	public void updateMember(Member dto) throws Exception;
	
	public Member findByEmail(String email);
	public List<String> listRoles(String email);

	public void deleteMember(Map<String, Object> map) throws Exception;
	
	public void generatePwd(Member dto) throws Exception;

	public int checkFailureCount(String userId);
	public void updateFailureCount(String userId) throws SQLException;
	public void updateMemberEnabled(Map<String, Object> map) throws Exception;
	public void insertMemberStatus(Member dto) throws Exception;
	public Long getMemberIdx(String userId);

	public Member findByUserEmail(String email);

	public void insertAuthority(Member dto) throws Exception;
	public void deleteAuthority(Map<String, Object> map) throws Exception;
	public String findByAuthority(String email);

	public boolean isPasswordCheck(String email, String password);
	public void updatePassword(Member dto) throws Exception;
	
	// 회원 배송지 세션 조회
	ShippingInfo getShippingInfo(Long memberIdx) throws Exception;



}
