package com.sp.app.service;

import com.sp.app.model.Change;

import java.util.List;
import java.util.Map;

public interface ChangeService {
    void insertChangeRequest(Change change);
    List<Change> getChangeState(long memberIdx);

    List<Change> getRequestList(Map<String, Object> map);
    int dataCount(long memberIdx);

}
