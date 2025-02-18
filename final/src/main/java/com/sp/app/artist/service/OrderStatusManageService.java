package com.sp.app.artist.service;

import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;
import com.sp.app.model.Destination;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface OrderStatusManageService {
    public int orderCount(Map<String, Object>map);
    public List<OrderManage> listOrder(Map<String, Object> map);
    public OrderManage findByOrderId(String item_code);
    public OrderProduct OrderDetails(String item_code);

    public List<Map<String,Object>> listDeliveryCompany();
    public Destination findByDeliveryId(String item_code);


}
