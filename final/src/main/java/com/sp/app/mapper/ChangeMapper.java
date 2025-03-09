package com.sp.app.mapper;

import com.sp.app.model.Change;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ChangeMapper {
    void insertChangeRequest(Change change);
    List<Change> getChangeState(long memberIdx);
    List<Change> getRequestList(Map<String, Object> map);
    int dataCount(long memberIdx);
    int countChangeRequest(Map<String, Object> map);

}
