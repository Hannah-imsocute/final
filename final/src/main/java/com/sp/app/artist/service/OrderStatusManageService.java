package com.sp.app.artist.service;

import com.sp.app.artist.model.OrderDetailManage;
import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;
import com.sp.app.artist.model.ShippingInfo;

import java.util.List;
import java.util.Map;
import java.util.Objects;

public interface OrderStatusManageService {
    public int orderCount(Map<String, Object>map);
    public List<OrderManage> listOrder(Map<String, Object> map);
    public OrderManage findByOrderId(String item_code);
    public OrderProduct OrderDetails(String item_code);

    public void updateOrder(String mode,Map<String,Object> map)throws Exception;

    public List<Map<String,Object>> listDeliveryCompany();
    public ShippingInfo findByDeliveryId(String item_code);


    public int detailCount(Map<String,Object> map);
    public List<OrderDetailManage> listDetails(Map<String,Object> map);

    public OrderDetailManage  findByDetailId(String item_code);
    public List<OrderDetailManage> listOrderDetails(String item_code);
    public  Map<String,Object> findByPayDetail(String item_code);

    public void updateOrderChangeState(Map<String,Object>map)throws Exception;

    public List<Map<String,Object>> listDetailStateInfo(String item_code);



}
