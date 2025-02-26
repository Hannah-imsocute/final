package com.sp.app.service;

import com.sp.app.mapper.AskMapper;
import com.sp.app.model.Ask;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class AskServiceImpl implements AskService{

    private final AskMapper mapper;

    @Override
    public void insertAsk(Ask dto) throws Exception{
        try {
            mapper.insertAsk(dto);
        } catch(Exception e) {
            log.info("insertAsk", e);
            throw e;
        }
    }

    @Override
    public List<Ask> getAskList(Map<String, Object> map) throws Exception {
        List<Ask> list = null;

        try {
            list = mapper.getAskList(map);
        } catch(Exception e) {
            log.info("getAskList", e);
        }
        return list;
    }

    @Override
    public int dataCount(long memberIdx) {
        return mapper.dataCount(memberIdx);
    }
}
