package com.sp.app.artist.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;

@Mapper
public interface OrderManageMapper {
            public int orderCount(Map<String,Object> map);
    public List<OrderManage> listOrder(Map<String, Object> map);
    public  OrderManage findByOrderId(String item_code);
    public OrderProduct OrderDetails(String item_code);


}
