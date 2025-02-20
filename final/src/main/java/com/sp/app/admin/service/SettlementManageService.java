package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import com.sp.app.admin.model.SettlementManage;

public interface SettlementManageService {
	public int dataCount(Map<String, Object> map);
	public List<SettlementManage> listSettlement(Map<String, Object> map);
	
	public SettlementManage findById(Long memberIdx);
	public SettlementManage findBySeller(String brandName);
	
	public void updateSettlement(Map<String, Object> map) throws Exception;
}
