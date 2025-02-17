package com.sp.app.service;

import com.sp.app.mapper.OrderMapper;
import com.sp.app.model.*;
import com.sp.app.model.cart.CartItem;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.atomic.AtomicLong;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrderServiceImpl implements OrderService{

  private final OrderMapper orderMapper;
  private static AtomicLong count = new AtomicLong(0);
  private final CartItemService cartItemService;


  @Override
  public long getLatestOrderCode() {
    long result = 0;
    try {
      result = orderMapper.getLatestOrderCode();
    } catch(Exception e) {
      log.info("getLatestOrderCode()", e);
    }
    return result;
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
  public void insertOrderDetail(Order orderDetail) throws SQLException {

  }

  @Override
  public void insertShippingAddress(ShippingInfo info) throws Exception {
    try {
      info.setReceiverName(info.getReceiverName());
      info.setPhone(info.getPhone());
      info.setAddDetail(info.getAddDetail());
      info.setAddTitle(info.getAddTitle());
      info.setFirstAdd(info.getFirstAdd()); // 기본 배송지로 저장


      orderMapper.insertShippingAddress(info);
    } catch(Exception e) {
      log.info("insertShippingAddress", e);
    }
  }

  @Override
  public void insertUserPoint(MemberPoint userPoint) throws Exception {

  }

  @Override
  public MemberPoint getLatestUserPoint(long userId) {
    return null;
  }

  @Override
  public List<Order> getOrderDetailList(Map<String, Object> params) {
    return List.of();
  }

  @Override
  public Order getOrderDetail(long orderDetailId) {
    return null;
  }

  @Override
  public MainProduct getProduct(long productId) {
    return null;
  }

  @Override
  public void decreaseProductStock(long productId, int quantity) throws SQLException {

  }

  @Override
  @Transactional
  public Order processOrder(SessionInfo sessionInfo) throws Exception {
    List<CartItem> cartItems = cartItemService.getCartListByMember(sessionInfo.getMemberIdx());
    if (cartItems == null || cartItems.isEmpty()) {
      throw new Exception("장바구니가 비어 있습니다.");
    }

    List<OrderItem> orderItems = new ArrayList<>();
    int overallNetPay = 0;
    for (CartItem cartItem : cartItems) {
      int totalPrice = cartItem.getQuantity() * cartItem.getPrice();
      int shipping = totalPrice >= 20000 ? 0 : 3000;
      int couponValue = cartItem.getCouponValue() != null ? cartItem.getCouponValue() : 0;
      int spentPoint = cartItem.getSpentPoint() != null ? cartItem.getSpentPoint() : 0;
      int netPay = totalPrice + shipping - couponValue - spentPoint;
      overallNetPay += netPay;

      OrderItem orderItem = OrderItem.builder()
              .productCode(cartItem.getProductCode())
              .options(cartItem.getCartOption())
              .priceForeach(cartItem.getPrice())
              .quantity(cartItem.getQuantity())
              .price(totalPrice)
              .shipping(shipping)
              .orderState(0) // 0이 기본값
              .build();
      orderItems.add(orderItem);
    }

    Order order = Order.builder()
            .memberIdx(sessionInfo.getMemberIdx())
            .email(sessionInfo.getEmail())
            .orderDate(java.time.LocalDateTime.now().toString())
            .addrNum(1)
            .totalPrice(overallNetPay)
            .couponCode(null)
            .couponValue(0)
            .spentPoint(0)
            .netPay(overallNetPay)
            .payment("카드")
            .orderItems(orderItems)
            .build();

    orderMapper.insertOrder(order);
    long orderCode = order.getOrderCode();

    for (OrderItem orderItem : orderItems) {
      orderItem.setOrderCode(orderCode);
      orderMapper.insertOrderDetail(orderItem);
    }

    cartItemService.deleteCartItem(sessionInfo.getMemberIdx());

    return order;
  }

  @Override
  public Order processOrder(SessionInfo sessionInfo, List<Long> selectedCartItemCodes) throws Exception {
    Map<String, Object> params = new HashMap<>();
    params.put("memberIdx", sessionInfo.getMemberIdx());
    params.put("selectedCodes", selectedCartItemCodes);

    List<CartItem> cartItems = cartItemService.getCartItemsByCodes(params);

    if (cartItems == null || cartItems.isEmpty()) {
      throw new Exception("장바구니가 비어 있습니다.");
    }

    List<OrderItem> orderItems = new ArrayList<>();
    int overallNetPay = 0;
    for (CartItem cartItem : cartItems) {
      int totalPrice = cartItem.getQuantity() * cartItem.getPrice();
      int shipping = totalPrice >= 20000 ? 0 : 3000;
      int couponValue = cartItem.getCouponValue() != null ? cartItem.getCouponValue() : 0;
      int spentPoint = cartItem.getSpentPoint() != null ? cartItem.getSpentPoint() : 0;
      int netPay = totalPrice + shipping - couponValue - spentPoint;
      overallNetPay += netPay;

      OrderItem orderItem = OrderItem.builder()
              .productCode(cartItem.getProductCode())
              .options(cartItem.getCartOption())
              .priceForeach(cartItem.getPrice())
              .quantity(cartItem.getQuantity())
              .price(totalPrice)
              .shipping(shipping)
              .orderState(0) // 0이 기본값
              .build();
      orderItems.add(orderItem);
    }

    Order order = Order.builder()
            .memberIdx(sessionInfo.getMemberIdx())
            .email(sessionInfo.getEmail())
            .orderDate(java.time.LocalDateTime.now().toString())
            .addrNum(1)
            .totalPrice(overallNetPay)
            .couponCode(null)
            .couponValue(0)
            .spentPoint(0)
            .netPay(overallNetPay)
            .payment("카드")
            .orderItems(orderItems)
            .build();

    orderMapper.insertOrder(order);
    long orderCode = order.getOrderCode();

    for (OrderItem orderItem : orderItems) {
      orderItem.setOrderCode(orderCode);
      orderMapper.insertOrderDetail(orderItem);
    }

    cartItemService.deleteCartItems(sessionInfo.getMemberIdx(), selectedCartItemCodes);
//    cartItemService.deleteCartItem(sessionInfo.getMemberIdx()); // 전체삭제

    return order;
  }


}
