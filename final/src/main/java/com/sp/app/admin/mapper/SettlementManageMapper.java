package com.sp.app.admin.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.admin.model.SettlementManage;

// 정산 관리에서 필요한게...
// 리스트 보기, 날짜 검색, 작가별로, 정산보류시 직접 정산버튼 눌러서
@Mapper
public interface SettlementManageMapper {
	public int dataCount(Map<String, Object> map);
	public List<SettlementManage> listSettlement(Map<String, Object> map);
	
	public SettlementManage findById(Long memberIdx);
	public SettlementManage findBySeller(String brandName);
	
	public void updateSettlement(Map<String, Object> map) throws SQLException;
	
}
