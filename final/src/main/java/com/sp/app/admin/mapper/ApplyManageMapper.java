package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.ApplyManage;

@Mapper
public interface ApplyManageMapper {
	// 입점 신청 데이터 수
	public int dataCount(Map<String, Object> map);

	// 입점 신청 데이터 삽입
	public void insertApply(ApplyManage dto) throws SQLException;
	
	public ApplyManage getSellerDetailsBySellerApplyNum(long sellerApplyNum);
	
	// 입점 신청 리스트
	public List<ApplyManage> listApply(Map<String, Object> map);

	// 승인 여부 업데이트 (승인/거절)
	public void updateApply(Map<String, Object> map) throws SQLException;

    // 권한 수정 (관리자가 권한을 수정)
    public void updateSeller(Map<String, Object> map) throws SQLException;

    // 회원 탈퇴 처리
    public void deleteSeller(Map<String, Object> map) throws SQLException;
}
