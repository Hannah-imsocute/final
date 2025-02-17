package com.sp.app.admin.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sp.app.admin.mapper.ApplyManageMapper;
import com.sp.app.admin.model.ApplyManage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApplyManageServiceImpl implements ApplyManageService {
	private final ApplyManageMapper mapper;

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
	public List<ApplyManage> listApply(Map<String, Object> map) {
		List<ApplyManage> list = null;
		
		try {
			list = mapper.listApply(map);
		} catch (Exception e) {
			log.info("listMember : ", e);
		}
		
		return list;
	}

	@Override
	@Transactional
	public void insertApply(ApplyManage dto) throws Exception {
		try {
			mapper.insertApply(dto);
		} catch (Exception e) {
			log.info("insertApply : ", e);
			
			throw e;
		}
		
	}

	@Override
	@Transactional
	public void updateApply(Map<String, Object> map) throws Exception {
		try {
			mapper.updateApply(map);
		} catch (Exception e) {
			log.info("updateApply : ", e);
		}
		
	}

	@Override
	public void updateSeller(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteSeller(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ApplyManage getSellerDetailsBySellerApplyNum(Long sellerApplyNum) {
		
		return mapper.getSellerDetailsBySellerApplyNum(sellerApplyNum);
	}

}
