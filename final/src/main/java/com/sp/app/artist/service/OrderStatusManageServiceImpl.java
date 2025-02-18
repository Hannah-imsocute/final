package com.sp.app.artist.service;

import com.sp.app.artist.mapper.OrderManageMapper;
import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;
import com.sp.app.model.Destination;
import com.sp.app.state.OrderState;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderStatusManageServiceImpl implements OrderStatusManageService{
        private final OrderManageMapper mapper;


    @Override
    public int orderCount(Map<String, Object> map) {
        int result = 0;

        try {
        result = mapper.orderCount(map);
        }catch (Exception e){
            log.info("orderCount : ",e);
        }

        return result;
    }

    @Override
    public List<OrderManage> listOrder(Map<String, Object> map) {
        List<OrderManage> list = null;

        try {
            list = mapper.listOrder(map);
            for (OrderManage dto : list){
                dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
            }

        }catch (Exception e){
            log.info("listOrder : ",e);
        }

        return list;
    }


    @Override
    public OrderManage findByOrderId(String item_code) {
        OrderManage dto = null;

        try {
        dto = mapper.findByOrderId(item_code);

        }
        catch (Exception e){
            log.info("findByOrderId : ",e);
        }

        return dto;
    }


    @Override
    public OrderProduct OrderDetails(String item_code) {
        OrderProduct dto = null;
        try {
            dto = mapper.OrderDetails(item_code);

            dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
        }catch (Exception e){
            log.info("OrderDetails");
        }

        return dto;
    }

    @Override
    public List<Map<String, Object>> listDeliveryCompany() {
        return null;
    }

    @Override
    public Destination findByDeliveryId(String item_code) {
        return null;
    }
}
