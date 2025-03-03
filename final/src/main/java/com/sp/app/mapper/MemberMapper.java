package com.sp.app.mapper;

import com.sp.app.model.Member;
import com.sp.app.model.Seller;
import com.sp.app.model.ShippingInfo;

import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface MemberMapper {
	public Member loginMember(String userId);
	public void updateLastLogin(String userId) throws SQLException;
	
	public void updateMemberEnabled(Map<String, Object> map) throws SQLException;
	public void updateMemberLevel(Map<String, Object> map) throws SQLException;
	public void updateMember1(Member dto) throws SQLException;
	public void updateMember2(Member dto) throws SQLException;
	
	public Member findByEmail(String userId);
	public Member findByMemberIdx(long memberIdx);
	public List<String> listRoles(String email);


	public void deleteMember1(Map<String, Object> map) throws SQLException;
	public void deleteMember2(Map<String, Object> map) throws SQLException;

	public int checkFailureCount(String email);
	public void updateFailureCount(String email) throws SQLException;

	public Member findByUserEmail(String email);
	public Long getMemberIdx(String email);
	public void generatePwd(Member dto) throws Exception;
	public boolean isPasswordCheck(String email, String password);

	public void insertAuthority(Map<String, Object> map) throws SQLException;
	public void deleteAuthority(Map<String, Object> map) throws SQLException;
	public String findByAuthority(String email);

	public void updateFailureCountReset(String userId) throws SQLException;

	ShippingInfo getShippingInfo(Long memberIdx) throws Exception;
	
	// 회원가입 insert
	public void insertMember1(Member dto) throws SQLException;
	public void insertMember2(Member dto) throws SQLException;
	public long getMemberidx(String email);
	public void inserAuthForSeller(Map<String, Object> map) throws SQLException;
	// 작가 이메일 검증 
	public int checkOfSeller(String email);
	
	// 입점 신청 내역 가져오기
	public Seller getHistory(String email);
	
	// 브랜드 및 계좌 insert 
	public void sellerinfo (Seller seller);
	public void sellerBankInfo(Seller seller);
}
