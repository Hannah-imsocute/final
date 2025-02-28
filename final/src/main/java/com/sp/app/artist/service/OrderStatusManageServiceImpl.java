package com.sp.app.artist.service;

import com.sp.app.artist.mapper.OrderManageMapper;
import com.sp.app.artist.model.*;
import com.sp.app.state.OrderState;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
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
    public void updateOrder(String mode, Map<String, Object> map) throws Exception {
        try {
            if (mode.equals("state")){
                mapper.updateOrderState(map);
            }else if(mode.equals("invoiceNumber")){
                mapper.updateOrderPackage(map);
                mapper.updateOrderState(map);
            }else if(mode.equals("delivery")){
                mapper.updateOrderState(map);
            }





        }catch (Exception e){
        log.info("updateOrder:",e);
        }
    }

    @Override
    public List<Map<String, Object>> listDeliveryCompany() {
        List<Map<String,Object>> list = null;
        try {
            list = mapper.listDeliveryCompany();
        }catch (Exception e){
            log.info("listDeliveryCompany : ",e);
        }


        return list;
    }

    @Override
    public ShippingInfo findByDeliveryId(String item_code) {
        ShippingInfo dto = null;
        try {
            dto =mapper.findByDeliveryId(item_code);
        }catch (Exception e){
            log.info("findByDeliveryId : ",e);
        }


        return dto;
    }

    @Override
    public int detailCount(Map<String, Object> map) {
        int result =0;

        try {
            result = mapper.detailCount(map);
        }catch (Exception e){
            log.info("detailCount : ",e);
        }
        return result;
    }

    @Override
    public List<OrderDetailManage> listDetails(Map<String,Object>map) {
        List<OrderDetailManage> list =null;
        try {
            list = mapper.listDetails(map);
            for(OrderDetailManage dto : list){
                dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
            }

        }catch (Exception e){
            log.info("listDetails",e);
        }



        return list;
    }

    @Override
    public OrderDetailManage findByDetailId(String item_code) {
        OrderDetailManage dto =null;
        try {
            dto = Objects.requireNonNull(mapper.findByDetailId(item_code));


            dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
        }catch (NullPointerException e){

        }catch (Exception e){
            log.info("findByDetailId:",e);
        }


        return dto;
    }

    @Override
    public List<OrderDetailManage> listOrderDetails(String item_code) {
        List<OrderDetailManage> list = null;

        try {
            list = mapper.listOrderDetails(item_code);
            for (OrderDetailManage dto: list ){
                dto.setOrderStateInfo(OrderState.ORDERSTATEINFO[dto.getOrderState()]);
            }


        }catch (Exception e){
            log.info("listOrderDetails:  ",e);
        }



        return list;
    }

    @Override
    public void updateOrderChangeState(Map<String, Object> map) throws Exception {
        try {
            //교환신청 및 환불신청
//            0:교환신청 1: 교환처리  2: 교환불가 4:교환완료
//            0:환불신청 1:환불처리 2:환불불가 3:환불성공 4:취소신청 5:취소처리 6:취소불가 7:취소완료
            //교환으로 오면 교환 인서트
            //환불로 오면 환불인서트
            String item_code = (String)map.get("item_code");
            int orderState = Integer.parseInt((String)map.get("orderState"));
            int productMoney = Integer.parseInt((String)map.get("productMoney"));
            int payment = Integer.parseInt((String)map.get("payment"));

            //상품 취소에 관한 전체 금액 가져오기
            int cancelAmount =0;
            if(orderState == 8||orderState==15 ){
                cancelAmount = Integer.parseInt((String)map.get("cancelAmount"));
            }
                //주문상태에 따른 상세상태 넣어주는 로직
            if (orderState == 9 || orderState == 10) {
                if (orderState == 10) {
                    map.put("detailState", 1);
                    mapper.insertChangeRequest(map);
                } else if (orderState == 11) {
                    map.put("detailState", 2);
                    mapper.insertChangeRequest(map);
                } else {
                    map.put("detailState", 3);
                    mapper.insertChangeRequest(map);
                }
            } else if (orderState == 13 || orderState == 14) {
                if (orderState == 14) {
                    map.put("refund_status", 1);
                    mapper.insertRefund(map);
                } else if (orderState == 15) {
                    map.put("refund_status", 2);
                    mapper.insertRefund(map);
                } else {
                    map.put("refund_status", 3);
                    mapper.insertRefund(map);
                }
            }


            mapper.updateOrderState(map);



        }catch (Exception e){
            log.info("updateOrderChangeState:",e);
        }

    }

    @Override
    public Map<String, Object> findByPayDetail(String item_code) {
        Map<String,Object> map = null;

        try {
            map = mapper.findByPayDetail(item_code);

        }catch (Exception e){
            log.info("findByPayDetail : ",e);
        }

        return map;
    }


    @Override
    public List<Map<String, Object>> listDetailStateInfo(String item_code) {
        List<Map<String,Object>> list = null;

        try {
            list = mapper.listDetailStateInfo(item_code);
            String detailStateInfo;
            for(Map<String,Object> map:list){
            //만약 orderstate가 교환이면 detailstateinforefund걸로 넣기
            int detailState = ((BigDecimal)map.get("STATE")).intValue();
            detailStateInfo = OrderState.DETAILSTATEINFOREFUNDS[detailState];
            map.put("DETAILSTATEINFO",detailStateInfo);
            }

        }catch (Exception e){
            log.info("listDetailStateInfo : ",e);
        }


        return list;
    }



}
