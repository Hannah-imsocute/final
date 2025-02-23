package com.sp.app.mapper;

import com.sp.app.model.OrderItem;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface OrderItemMapper {

    void insertOrderCancel(OrderItem orderItem) throws Exception;

    void updateOrderIemState(Map<String, Object> map) throws Exception;

    void insertPaymentRefund(OrderItem orderItem) throws Exception;

    Long getItemCode(); // 상품 아이템 코드 가지고오기

}
