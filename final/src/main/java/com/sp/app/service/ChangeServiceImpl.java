package com.sp.app.service;

import com.sp.app.mapper.ChangeMapper;
import com.sp.app.model.Change;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChangeServiceImpl implements ChangeService {
    private final ChangeMapper mapper;
    @Override
    public void insertChangeRequest(Change change) {
        try {
            change.setMemberIdx(change.getMemberIdx());
            change.setItemCode(change.getItemCode());
            change.setChangeRequest(change.getChangeRequest());
            change.setChangeState(0); // 교환진행상태
            mapper.insertChangeRequest(change);
        } catch(Exception e) {
            log.info("insertChangeRequest", e);
            throw e;
        }
    }

    @Override
    public List<Change> getChangeState(long memberIdx) {
        List<Change> list = null;
        try {
            list = mapper.getChangeState(memberIdx);
        } catch(Exception e) {
            log.info("getChangeState", e);
        }
        return list;
    }

    @Override
    public List<Change> getRequestList(Map<String, Object> map) {
        List<Change> list = null;
        try {
            list = mapper.getRequestList(map);
        } catch(Exception e) {
            log.info("getRequestList", e);
        }
        return list;
    }

    @Override
    public int dataCount(long memberIdx) {
        return mapper.dataCount(memberIdx);
    }
}
