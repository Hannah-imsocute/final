package com.sp.app.service;

import com.sp.app.mapper.MemberMapper;
import com.sp.app.model.Member;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberServiceImpl implements MemberService {
	private final MemberMapper mapper;
	
	@Override
	public Member loginMember(String userId) {
		Member dto = null;

		try {
			dto = mapper.loginMember(userId);
		} catch (Exception e) {
			log.info("loginMember : ", e);
		}

		return dto;
	}

	@Override
	public void insertMember(Member dto) throws Exception {

	}

	@Override
	public void updateLastLogin(String userId) throws Exception {

	}

	@Override
	public void updateMember(Member dto) throws Exception {
		
	}

	@Override
	public Member findById(String userId) {

		return null;
	}

	@Override
	public Member findById(long memberIdx) {

		return null;
	}

	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		
	}

	@Override
	public void generatePwd(Member dto) throws Exception {
		
	}
}
