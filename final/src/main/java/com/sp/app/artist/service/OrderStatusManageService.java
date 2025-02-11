package com.sp.app.artist.service;

import com.sp.app.artist.model.OrderManage;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface OrderStatusManageService {
    public int orderCount(Map<String, Object>map);
    public List<OrderManage> listOrder(Map<String, Object> map);

}
