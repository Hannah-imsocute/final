package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.admin.mapper.SettlementManageMapper;
import com.sp.app.admin.model.SettlementManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SettlementManageServiceImpl implements SettlementManageService {
	private final SettlementManageMapper mapper;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<SettlementManage> listSettlement(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SettlementManage findById(Long memberIdx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public SettlementManage findBySeller(String brandName) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateSettlement(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
