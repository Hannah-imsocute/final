package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

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
	public List<SettlementManage> findByOrderCodeAndDateRange(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return null;
	}
	
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
	public int dataCount2(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount2(map);
		} catch (Exception e) {
			log.info("dataCount2 : ", e);
		}
		
		return result;
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

	@Override
	public List<SettlementManage> listSettlementMainTab1SubTab1(Map<String, Object> map) {
		List<SettlementManage> list = null;
		
		try {
			list = mapper.listSettlementMainTab1SubTab1(map);
		} catch (Exception e) {
			log.info("listSettlementMainTab1SubTab1 : ", e);
		}
		
		return list;
	}

	@Override
	public List<SettlementManage> listSettlementMainTab1SubTab2(Map<String, Object> map) {
		List<SettlementManage> list = null;
		
		try {
			list = mapper.listSettlementMainTab1SubTab2(map);
		} catch (Exception e) {
			log.info("listSettlementMainTab1SubTab2 : ", e);
		}
		
		return list;
	}

	@Override
	public List<SettlementManage> listSettlementMainTab2SubTab1(Map<String, Object> map) {
		List<SettlementManage> list = null;
		
		try {
			list = mapper.listSettlementMainTab2SubTab1(map);
		} catch (Exception e) {
			log.info("listSettlementMainTab2SubTab1 : ", e);
		}
		
		return list;
	}

	@Override
	public List<SettlementManage> listSettlementMainTab2SubTab2(Map<String, Object> map) {
		List<SettlementManage> list = null;
		
		try {
			list = mapper.listSettlementMainTab2SubTab1(map);
		} catch (Exception e) {
			log.info("listSettlementMainTab2SubTab2 : ", e);
		}
		
		return list;
	}

	@Override
	public SettlementManage findById(String settlement_num) {
		SettlementManage dto = null;
		
		try {
			dto = Objects.requireNonNull(mapper.findById(settlement_num));
		} catch (Exception e) {
			log.info("findById : ", e);
		}
		
		return dto;
	}

}
