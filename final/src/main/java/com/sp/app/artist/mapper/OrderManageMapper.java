package com.sp.app.artist.mapper;

import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;
import com.sp.app.model.Destination;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderManageMapper {
            public int orderCount(Map<String,Object> map);
    public List<OrderManage> listOrder(Map<String, Object> map);
    public  OrderManage findByOrderId(String item_code);
    public OrderProduct OrderDetails(String item_code);


//    public List<Map<String,Object>> listDeliveryCompany();
    public Destination findByDeliveryId(String item_code);

}
