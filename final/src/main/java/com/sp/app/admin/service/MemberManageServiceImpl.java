package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.MemberManageMapper;
import com.sp.app.admin.model.MemberManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MemberManageServiceImpl implements MemberManageService {
	private final MemberManageMapper mapper;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		
		return result;
	}

	@Override
	public List<MemberManage> listMember(Map<String, Object> map) {
		List<MemberManage> list = null;
		
		try {
			list = mapper.listMember(map);
		} catch (Exception e) {
			log.info("listMember : ", e);
		}
		
		return list;
	}

	@Override
	public MemberManage findById(Long memberIdx) {
		MemberManage dto = null;

		try {
			// 객체 = Objects.requireNonNull(객체)
			//  : 파라미터로 입력된 값이 null 이면 NullPointerException를 발생하고,
			//    그렇지 않다면 입력값을 그대로 반환
			dto = Objects.requireNonNull(mapper.findById(memberIdx));

			if (dto.getEmail() != null) {
				String[] s = dto.getEmail().split("@");
				dto.setEmail1(s[0]);
				dto.setEmail2(s[1]);
			}

			if (dto.getPhone() != null) {
				String[] s = dto.getPhone().split("-");
				dto.setPhone1(null);
				dto.setPhone2(s[1]);
				dto.setPhone3(s[2]);
			}
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}
	
	@Override
	public MemberManage findById(String userId) {
		MemberManage dto = null;

		try {
			dto = Objects.requireNonNull(mapper.findByUserId(userId));

			if (dto.getEmail() != null) {
				String[] s = dto.getEmail().split("@");
				dto.setEmail1(s[0]);
				dto.setEmail2(s[1]);
			}

			if (dto.getPhone() != null) {
				String[] s = dto.getPhone().split("-");
				dto.setPhone1(s[0]);
				dto.setPhone2(s[1]);
				dto.setPhone3(s[2]);
			}
		} catch (NullPointerException e) {
		} catch (ArrayIndexOutOfBoundsException e) {
		} catch (Exception e) {
			log.info("findById : ", e);
		}

		return dto;
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updateMember(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMember1(map);
			mapper.updateMember2(map);
			
			mapper.updateAuthority(map);
			
		} catch (Exception e) {
			log.info("updateMember : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateMemberEnabled(Map<String, Object> map) throws Exception {
		try {
			mapper.updateMemberEnabled(map);
		} catch (Exception e) {
			log.info("updateMemberEnabled : ", e);
			
			throw e;
		}
	}

	@Override
	public void updateFailureCountReset(Long memberIdx) throws Exception {
		try {
			mapper.updateFailureCountReset(memberIdx);
		} catch (Exception e) {
			log.info("updateFailureCountReset : ", e);
			
			throw e;
		}
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void deleteMember(Map<String, Object> map) throws Exception {
		try {
			mapper.deleteAuthority(map);
			mapper.deleteMember2(map);
			mapper.deleteMember1(map);
		} catch (Exception e) {
			log.info("updateMember : ", e);
			
			throw e;
		}
	}
	
	@Override
	public void insertMemberStatus(MemberManage dto) throws Exception {
		try {
			mapper.insertMemberStatus(dto);
		} catch (Exception e) {
			log.info("insertMemberStatus : ", e);
						
			throw e;
		}
	}

	
	@Override
	public List<MemberManage> listMemberStatus(Long memberIdx) {
		List<MemberManage> list = null;
		
		try {
			list = mapper.listMemberStatus(memberIdx);
		} catch (Exception e) {
			log.info("listMemberStatus : ", e);
		}
		
		return list;
	}

	@Override
	public MemberManage findByStatus(Long memberIdx) {
		MemberManage dto = null;

		try {
			dto = mapper.findByStatus(memberIdx);
		} catch (Exception e) {
			log.info("findByStatus : ", e);
		}

		return dto;
	}

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
	
}
