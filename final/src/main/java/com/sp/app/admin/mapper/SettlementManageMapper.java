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
	public int dataCount2(Map<String, Object> map);
	public List<SettlementManage> listSettlementMainTab1SubTab1(Map<String, Object> map);
	public List<SettlementManage> listSettlementMainTab1SubTab2(Map<String, Object> map);
	public List<SettlementManage> listSettlementMainTab2SubTab1(Map<String, Object> map);
	public List<SettlementManage> listSettlementMainTab2SubTab2(Map<String, Object> map);
	
	public SettlementManage findById(String settlement_num);
	public SettlementManage findBySeller(String brandName);
	
	public void updateSettlement(Map<String, Object> map) throws SQLException;
	
}
