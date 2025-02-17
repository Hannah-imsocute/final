package com.sp.app.service;

import com.sp.app.mapper.OrderMapper;
import com.sp.app.model.*;
import com.sp.app.model.cart.CartItem;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
  public String getLatestOrderCode() {
    String result = "";
    try {
      LocalDate now = LocalDate.now();
      String preNumber = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
      String savedPreNumber = "";
      long savedLastNumber = 0;
      String maxOrderNumber = orderMapper.getLatestOrderCode();

      if (maxOrderNumber != null && maxOrderNumber.length() > 8) {
        savedPreNumber = maxOrderNumber.substring(0, 8);
        savedLastNumber = Long.parseLong(maxOrderNumber.substring(8));
      }

      long lastNumber = 1;
      if (!preNumber.equals(savedPreNumber)) {
        count.set(0);
        lastNumber = count.incrementAndGet();
      } else {
        lastNumber = count.incrementAndGet();
        if (savedLastNumber >= lastNumber) {
          count.set(savedLastNumber);
          lastNumber = count.incrementAndGet();
        }
      }

      result = preNumber + String.format("%09d", lastNumber);

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
    try {
      orderMapper.insertPayment(payment);
    } catch(Exception e) {
      log.info("insertPayment", e);
    }
  }

  @Override
  public void insertOrderDetail(OrderItem item) throws SQLException {
    try {
      orderMapper.insertOrderDetail(item);

    } catch(Exception e) {
      log.info("insertOrderDetail", e);
    }
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

  /*유저 포인트 등록 구매할때 x 리뷰 참여시에 포인트준다..*/
  @Override
  public void insertUserPoint(MemberPoint userPoint) throws Exception {
    try {
      orderMapper.insertUserPoint(userPoint);
    } catch(Exception e) {
      log.info("userPoint", e);
      throw e;
    }
  }

  @Override
  public MemberPoint getLatestUserPoint(long memberIdx) {
    MemberPoint memberPoint = null;
    try {
      memberPoint = orderMapper.getLatestUserPoint(memberIdx); // memberIdx
    } catch(Exception e) {
      log.info("getLatestUserPoint", e);
    }
    return memberPoint;
  }

  @Override
  public List<Order> getOrderDetailList(Map<String, Object> params) {
    List<Order> list = null;
    try {
      list = orderMapper.getOrderDetailList(params);
    } catch(Exception e) {
      log.info("getOrderDetailList");
    }
    return list;
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
  public void decreaseProductStock(Map<String, Object> map) throws SQLException {
    try {
      orderMapper.decreaseProductStock(map);
    } catch(Exception e) {
      log.info("decreaseProductStock", e);
    }
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
    String orderCode = getLatestOrderCode();

    Order order = Order.builder()
            .memberIdx(sessionInfo.getMemberIdx())
            .email(sessionInfo.getEmail())
            .orderDate(java.time.LocalDateTime.now().toString())
            .orderCode(orderCode)
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
            .orderDate(java.time.LocalDateTime.now().toString()) // 주문일시
            .orderCode(getLatestOrderCode())
            .addrNum(1) // 배송지 주소(기본값)
            .totalPrice(overallNetPay) // 전체 가격
            .couponCode(null) // 쿠폰코드
            .couponValue(0) // 쿠폰가격
            .spentPoint(0) // 사용 포인트
            .netPay(overallNetPay) // 최종 결제 금액
            .payment("카드") //
            .orderItems(orderItems) // 개별 주문 항목 리스트
            .build();

    orderMapper.insertOrder(order);
//    String orderCode = order.getOrderCode();

    for (OrderItem orderItem : orderItems) {
      orderItem.setOrderCode(getLatestOrderCode());
      orderMapper.insertOrderDetail(orderItem);
    }

    cartItemService.deleteCartItems(sessionInfo.getMemberIdx(), selectedCartItemCodes);
//    cartItemService.deleteCartItem(sessionInfo.getMemberIdx()); // 전체삭제

    return order;
  }


}
