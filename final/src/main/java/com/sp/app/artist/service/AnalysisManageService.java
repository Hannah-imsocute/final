package com.sp.app.artist.service;

import java.util.List;
import java.util.Map;

public interface AnalysisManageService {
    public Map<String, Object> todayProduct(long memberIdx);

    public Map<String, Object> thisMonthProduct(long memberIdx);
    public Map<String, Object> previousMonthProduct(long memberIdx);

    public List<Map<String, Object>> dayTotalMoney(Map<String,Object>map);
    public List<Map<String, Object>> dayTotalMoney2(Map<String,Object>map);
    public List<Map<String, Object>> monthTotalMoney(Map<String,Object>map);
    public List<Map<String, Object>> monthTotalMoney2(Map<String,Object>map);
    public Map<String, Object> dayOfWeekTotalCount(Map<String,Object>map);
}
