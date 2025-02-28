package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.SettlementManage;

public interface SettlementManageService {
	public int dataCount(Map<String, Object> map);
	public int dataCount2(Map<String, Object> map);
	public List<SettlementManage> listSettlementMainTab1SubTab1(Map<String, Object> map);
	public List<SettlementManage> listSettlementMainTab1SubTab2(Map<String, Object> map);
	public List<SettlementManage> listSettlementMainTab2SubTab1(Map<String, Object> map);
	public List<SettlementManage> listSettlementMainTab2SubTab2(Map<String, Object> map);
	
	public SettlementManage findByOrderCodeAndDateRange(String settlement_num);
	
	public SettlementManage findById(String settlement_num);
	public SettlementManage findBySeller(String brandName);
	
	public void updateSettlement(Map<String, Object> map) throws Exception;
}
