package com.sp.app.service;

import com.sp.app.mapper.OrderMapper;
import com.sp.app.model.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderServiceImpl implements OrderService{

  private final OrderMapper orderMapper;
//  private final MyPageMapper myPageMapper;

  private static AtomicLong count = new AtomicLong(0);

//  @Override
  public String productOrderNumber() {
    // 상품 주문 번호 생성
    String result = "";

    try {
      Calendar cal = Calendar.getInstance();
      String y =String.format("%04d", cal.get(Calendar.YEAR));
      String m = String.format("%02d", (cal.get(Calendar.MONTH) + 1));
      String d = String.format("%03d", cal.get(Calendar.DATE) * 7);

      String preNumber = y + m + d;
      String savedPreNumber = "0";
      long savedLastNumber = 0;
      String maxOrderNumber = String.valueOf(orderMapper.getLatestOrderCode());
      if(maxOrderNumber != null && maxOrderNumber.length() > 9) {
        savedPreNumber = maxOrderNumber.substring(0, 9);
        savedLastNumber = Long.parseLong(maxOrderNumber.substring(9));
      }

      long lastNumber = 1;
      if(! preNumber.equals(savedPreNumber)) {
        count.set(0);
        lastNumber = count.incrementAndGet();
      } else {
        lastNumber = count.incrementAndGet();

        if( savedLastNumber >= lastNumber )  {
          count.set(savedLastNumber);
          lastNumber = count.incrementAndGet();
        }
      }

      result = preNumber + String.format("%09d", lastNumber);

    } catch (Exception e) {
      log.info("productOrderNumber : ", e);
    }

    return result;
  }

  @Override
  public long getLatestOrderCode() {
    return 0;
  }

  @Override
  public void insertOrder(Order order) throws Exception {
    try {
      orderMapper.insertOrder(order);
    } catch (Exception e) {
     log.info("insertOrder", e);
    }
  }

  @Override
  public void insertPayment(Payment payment) throws Exception {

  }

  @Override
  public void insertOrderDetail(OrderDetail orderDetail) throws SQLException {

  }

  @Override
  public void insertShippingAddress(ShippingInfo shippingInfo) throws Exception {

  }

  @Override
  public void insertUserPoint(MemberPoint userPoint) throws Exception {

  }

  @Override
  public MemberPoint getLatestUserPoint(long userId) {
    return null;
  }

  @Override
  public List<OrderDetail> getOrderDetailList(Map<String, Object> params) {
    return List.of();
  }

  @Override
  public OrderDetail getOrderDetail(long orderDetailId) {
    return null;
  }

  @Override
  public MainProduct getProduct(long productId) {
    return null;
  }

  @Override
  public void decreaseProductStock(long productId, int quantity) throws SQLException {

  }
}
