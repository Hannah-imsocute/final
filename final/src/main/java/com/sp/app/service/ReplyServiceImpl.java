package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.common.MyUtil;
import com.sp.app.mapper.ReplyMapper;
import com.sp.app.model.Reply;
import com.sp.app.model.SessionInfo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService{
	private final ReplyMapper mapper;
	private final MyUtil myUtil;

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			mapper.insertReply(dto);
		} catch (Exception e) {
			log.info("insertReply : ", e);
		}
		
	}




	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int result = 0;
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}




	@Override
	public List<Reply> listReply(Map<String, Object> map) throws Exception {
		List<Reply> list = null;
		
		try {
			System.out.println("#############"+map.toString());
			list = mapper.listReply(map);
			
			for(Reply dto : list) {
				dto.setContent(myUtil.htmlSymbols(dto.getContent()));
				dto.setNickName(myUtil.nameMasking(dto.getNickName()));

			}
			
		} catch (Exception e) {
			log.info("listReply : ", e);
		}
		return list;
	}
}