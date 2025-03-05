package com.sp.app.artist.mapper;

import com.sp.app.artist.model.OrderDetailManage;
import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;
import com.sp.app.artist.model.ShippingInfo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface TotalManageMapper {
    public Map<String, Object> todayProduct(long memberIdx);

    public Map<String, Object> thisMonthProduct(long memberIdx);
    public Map<String, Object> previousMonthProduct(long memberIdx);

    public List<Map<String, Object>> dayTotalMoney(Map<String,Object>map);
    public List<Map<String, Object>> dayTotalMoney2(Map<String,Object>map);
    public List<Map<String, Object>> monthTotalMoney(Map<String,Object>map);
    public List<Map<String, Object>> monthTotalMoney2(Map<String,Object>map);
    public Map<String, Object> dayOfWeekTotalCount(Map<String,Object>map);
}

