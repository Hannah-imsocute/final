package com.sp.app.service;

import com.sp.app.model.Ask;

import java.util.List;
import java.util.Map;

public interface AskService {
    void insertAsk(Ask ask) throws Exception;
    List<Ask> getAskList(Map<String, Object> map) throws Exception;
    int dataCount(long memberIdx);

}
