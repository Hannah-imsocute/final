package com.sp.app.artist.service;

import java.util.List;
import java.util.Map;

import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;

public interface OrderStatusManageService {
    public int orderCount(Map<String, Object>map);
    public List<OrderManage> listOrder(Map<String, Object> map);
    public OrderManage findByOrderId(String item_code);
    public OrderProduct OrderDetails(String item_code);

    public List<Map<String,Object>> listDeliveryCompany();
 

}
