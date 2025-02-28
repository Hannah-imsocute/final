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
public interface OrderManageMapper {
            public int orderCount(Map<String,Object> map);
    public List<OrderManage> listOrder(Map<String, Object> map);
    public  OrderManage findByOrderId(String item_code);
    public OrderProduct OrderDetails(String item_code);

    public void updateOrderPackage(Map<String,Object> map);
    public void updateOrderState(Map<String,Object>map);
    public List<Map<String,Object>> listDeliveryCompany();
    public ShippingInfo findByDeliveryId(String item_code);
    public void updateCancelAmount(Map<String, Object> map) throws SQLException;

    public int detailCount(Map<String,Object>map);
    public List<OrderDetailManage> listDetails(Map<String,Object>map);

    public OrderDetailManage findByDetailId(String item_code);
    public List<OrderDetailManage> listOrderDetails(String item_code);
    public  Map<String,Object> findByPayDetail(String item_code);
    public  void insertChangeRequest(Map<String,Object>map)throws SQLException;
    public  void insertRefund(Map<String,Object>map)throws SQLException;

    public List<Map<String,Object>> listDetailStateInfo(String item_code);

}

