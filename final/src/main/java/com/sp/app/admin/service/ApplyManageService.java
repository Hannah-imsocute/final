package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.ApplyManage;
import com.sp.app.admin.model.MemberManage;

public interface ApplyManageService {
	public int dataCount(Map<String, Object> map);
	public List<ApplyManage> listApply(Map<String, Object> map);
	
	public MemberManage findById(Long memberIdx);
	public MemberManage findById(String userId);
	
	public void updateMember(Map<String, Object> map) throws Exception;
	public void updateMemberEnabled(Map<String, Object> map) throws Exception;
	public void updateFailureCountReset(Long memberIdx) throws Exception;
	public void deleteMember(Map<String, Object> map) throws Exception;
	
	public void insertApply(ApplyManage dto) throws Exception;
	public List<MemberManage> listMemberStatus(Long memberIdx);
	public MemberManage insertApply(Long memberIdx);
	
	public List<Map<String, Object>> listAgeSection();

}
