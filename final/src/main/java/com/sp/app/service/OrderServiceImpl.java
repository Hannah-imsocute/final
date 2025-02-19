package com.sp.app.service;

import com.sp.app.mapper.OrderMapper;
import com.sp.app.mapper.ShippingMapper;
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
public class OrderServiceImpl implements OrderService {

  private final OrderMapper orderMapper;
  private final ShippingMapper shippingMapper;
  // 날짜 기반 주문 코드 생성 시 사용
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

      long lastNumber;
      if (!preNumber.equals(savedPreNumber)) {
        // 날짜가 바뀐 경우 카운트 리셋
        count.set(0);
        lastNumber = count.incrementAndGet();
      } else {
        // 같은 날짜인 경우
        lastNumber = count.incrementAndGet();
        if (savedLastNumber >= lastNumber) {
          count.set(savedLastNumber);
          lastNumber = count.incrementAndGet();
        }
      }

      result = preNumber + String.format("%09d", lastNumber);

    } catch (Exception e) {
      log.info("getLatestOrderCode() ", e);
    }
    return result;
  }

  @Transactional(rollbackFor = Exception.class)
  @Override
  public void insertOrder(Order dto) throws Exception {
    try {
      // 주문 테이블 저장
      orderMapper.insertOrder(dto);

      // 결제 정보가 있다면 저장
      if (dto.getPayments() != null) {
        orderMapper.insertPayment(dto.getPayments());
      }

      // 상세 주문 정보 저장
      if (dto.getProductCodes() != null && !dto.getProductCodes().isEmpty()) {
        for (int i = 0; i < dto.getProductCodes().size(); i++) {
          dto.setProductCode(dto.getProductCodes().get(i));
          dto.setQuantity(dto.getQuantities().get(i));
          // 옵션 문자열을 List로 변환
          if (dto.getOptions1() != null) {
            String[] options = dto.getOptions1().split(",");
            List<String> optionsList = new ArrayList<>();
            for (String option : options) {
              optionsList.add(option.trim());
            }
            dto.setOptionsList(optionsList);
          }
          dto.setPriceForeach(dto.getPriceForeachs().get(i));
          dto.setPrice(dto.getPrices().get(i));
          dto.setOrderState(0);

          orderMapper.insertOrderDetail(dto.getOrderItem());
        }
      }

      // 포인트 사용하면 
      if (dto.getSpentPoint() > 0) {
        LocalDate now = LocalDate.now();
        String dateTime = now.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        MemberPoint memberPoint = new MemberPoint();
        memberPoint.setMemberIdx(dto.getMemberIdx());
        memberPoint.setOrderCode(dto.getOrderCode());
        memberPoint.setUsedAmount(dto.getSpentPoint());
        memberPoint.setBalance(-dto.getSpentPoint());
//        memberPoint.setPointSaveNum(1); // 적립코드?
        memberPoint.setUsedDate(dateTime);
        memberPoint.setExpireDate(dto.getExpireDate());

        orderMapper.insertUserPoint(memberPoint);
      }


      dto.getShippingInfo().setState("상품준비중");
      shippingMapper.insertPackage(dto.getShippingInfo());

//      log.debug(shippingInfo.getPostCode());
//      log.info("new ShippingInfo{}", shippingInfo);

    } catch (Exception e) {
      log.info("insertOrder() ", e);
      throw e; 
    }
  }

  @Transactional(rollbackFor = Exception.class)
  @Override
  public void insertPayment(Payment payment) throws Exception {
    try {
      orderMapper.insertPayment(payment);
    } catch (Exception e) {
      log.info("insertPayment() ", e);
      throw e;
    }
  }

  @Transactional(rollbackFor = Exception.class)
  @Override
  public void insertOrderDetail(OrderItem item) throws SQLException {
    try {
      orderMapper.insertOrderDetail(item);
    } catch (Exception e) {
      log.info("insertOrderDetail() ", e);
      throw e;
    }
  }

  @Transactional(rollbackFor = Exception.class)
  @Override
  public void insertShippingAddress(ShippingInfo info) throws Exception {
    try {
      orderMapper.insertShippingAddress(info);
    } catch (Exception e) {
      log.info("insertShippingAddress() ", e);
      throw e;
    }
  }

  @Transactional(rollbackFor = Exception.class)
  @Override
  public void insertUserPoint(MemberPoint userPoint) throws Exception {
    try {
      orderMapper.insertUserPoint(userPoint);
    } catch (Exception e) {
      log.info("insertUserPoint() ", e);
      throw e;
    }
  }

  @Override
  public MemberPoint getLatestUserPoint(long memberIdx) {
    MemberPoint memberPoint = null;
    try {
      memberPoint = orderMapper.getLatestUserPoint(memberIdx);
    } catch (Exception e) {
      log.info("getLatestUserPoint() ", e);
    }
    return memberPoint;
  }

  @Override
  public List<Coupon> getCouponList(long memberIdx) {
    List<Coupon> list = null;
    try {
      list = orderMapper.getCouponList(memberIdx);
    } catch (Exception e) {
      log.info("getCouponList() ", e);
      throw e;
    }
    return list;
  }

  @Override
  public List<Order> getOrderDetailList(String orderCode) {
    List<Order> list = null;
    try {
      list = orderMapper.getOrderDetailList(orderCode);
    } catch (Exception e) {
      log.info("getOrderDetailList() ", e);
    }
    return list;
  }

  @Override
  public List<Order> listOrderProduct(List<Map<String, Long>> list) {
    List<Order> listProduct = null;
    try {
      listProduct = orderMapper.listOrderProduct(list);
      for (Order dto : listProduct) {
        int discountPrice = 0;
        if (dto.getDiscount() > 0) {
          discountPrice = (int) (dto.getPrice() * (dto.getDiscount() / 100.0));
          dto.setDiscount(discountPrice);
        }
        dto.setSalePrice(dto.getPrice() - discountPrice);
      }
    } catch (Exception e) {
      log.info("listOrderProduct() ", e);
    }
    return listProduct;
  }

  @Override
  public Order getOrderDetail(long orderDetailId) {
    // 필요 시 구현
    return null;
  }

  @Override
  public MainProduct getProduct(long productId) {
    return null;
  }

  @Override
  public OrderItem getProductCode(long productId) {
    OrderItem dto = null;
    try {
      dto = orderMapper.getProduct(productId);
    } catch(Exception e) {
      log.info("getProduct", e);
    }
    return dto;
  }

  /**
   * [공통 로직] 장바구니 아이템 목록 + 추가 정보(orderFromView)로 주문 처리
   */
  private Order processOrderCommon(SessionInfo sessionInfo, List<CartItem> cartItems, Order orderFromView) throws Exception {
    if (cartItems == null || cartItems.isEmpty()) {
      throw new Exception("장바구니가 비어 있습니다.(또는 상품이 선택되지 않았습니다.)");
    }

    List<OrderItem> orderItems = new ArrayList<>();
    int overallNetPay = 0;

    for (CartItem cartItem : cartItems) {
      int totalPrice = cartItem.getQuantity() * cartItem.getPrice();
      int shipping = (totalPrice >= 20000) ? 0 : 3000;
      int couponValueForItem = (cartItem.getCouponValue() != null) ? cartItem.getCouponValue() : 0;
      int spentPointForItem = (cartItem.getSpentPoint() != null) ? cartItem.getSpentPoint() : 0;
      int netPay = totalPrice + shipping - couponValueForItem - spentPointForItem;
      overallNetPay += netPay;

      OrderItem orderItem = OrderItem.builder()
              .productCode(cartItem.getProductCode())
              .options(cartItem.getCartOption())
              .priceForeach(cartItem.getPrice())
              .quantity(cartItem.getQuantity())
              .price(totalPrice)
              .shipping(shipping)
              .orderState(0)
              .build();
      orderItems.add(orderItem);
    }

    // 1) 주문코드 생성
    String orderCode = getLatestOrderCode();

    // 2) 뷰에서 넘어온 쿠폰, 포인트, 결제수단 등을 반영 (null 체크 추가)
    String payment = (orderFromView != null && orderFromView.getPayment() != null)
            ? orderFromView.getPayment() : "카드";

    int usedPoint = (orderFromView != null && orderFromView.getSpentPoint() != null)
            ? orderFromView.getSpentPoint() : 0;
    int couponVal = (orderFromView != null && orderFromView.getCouponValue() != null)
            ? orderFromView.getCouponValue() : 0;


    int finalNetPay = overallNetPay - couponVal - usedPoint;
    if (finalNetPay < 0) finalNetPay = 0;

    Order order = Order.builder()
            .memberIdx(sessionInfo.getMemberIdx())
            .email(sessionInfo.getEmail())
            .orderDate(java.time.LocalDateTime.now().toString())
            .orderCode(orderCode)
            .totalPrice(overallNetPay)
            .couponCode((orderFromView != null) ? orderFromView.getCouponCode() : null)
            .couponValue(couponVal)
            .spentPoint(usedPoint)
            .netPay(finalNetPay)
            .payment(payment)
            .orderItems(orderItems)
            .build();

    // 3) DB Insert
    orderMapper.insertOrder(order);
    for (OrderItem orderItem : orderItems) {
      orderItem.setOrderCode(orderCode);
      orderMapper.insertOrderDetail(orderItem);
    }

    // 4) 장바구니 아이템 삭제
    List<Long> cartItemIds = new ArrayList<>();
    for (CartItem c : cartItems) {
      cartItemIds.add(c.getCartItemCode());
    }
    cartItemService.deleteCartItems(sessionInfo.getMemberIdx(), cartItemIds);

    return order;
  }
  /**
   * [기존] 전체 장바구니 아이템 구매 로직
   * orderFromView 없이 사용하면 쿠폰, 포인트 등 반영 안 됨
   * -> deprecated 느낌으로 두거나, 아래 메서드처럼 변경 가능
   */
  @Override
  @Transactional(rollbackFor = Exception.class)
  public Order processOrder(SessionInfo sessionInfo) throws Exception {
    // 전체 장바구니 가져오기
    List<CartItem> cartItems = cartItemService.getCartListByMember(sessionInfo.getMemberIdx());
    // orderFromView = null 로 처리
    return processOrderCommon(sessionInfo, cartItems, null);
  }

  /**
   * [기존] 선택된 장바구니 아이템 구매
   * orderFromView 없이 사용하면 쿠폰, 포인트 등 반영 안 됨
   */
  @Override
  @Transactional(rollbackFor = Exception.class)
  public Order processOrder(SessionInfo sessionInfo, List<Long> selectedCartItemCodes) throws Exception {
    Map<String, Object> params = new HashMap<>();
    params.put("memberIdx", sessionInfo.getMemberIdx());
    params.put("selectedCodes", selectedCartItemCodes);

    List<CartItem> cartItems = cartItemService.getCartItemsByCodes(params);
    return processOrderCommon(sessionInfo, cartItems, null);
  }

  /**
   * [개선된] 선택된 장바구니 아이템 구매 + 사용자 입력(OrderFromView) 반영
   */
  @Override
  @Transactional(rollbackFor = Exception.class)
  public Order processOrder(SessionInfo sessionInfo, List<Long> selectedCartItemCodes, Order orderFromView) throws Exception {
    Map<String, Object> params = new HashMap<>();
    params.put("memberIdx", sessionInfo.getMemberIdx());
    params.put("selectedCodes", selectedCartItemCodes);

    List<CartItem> cartItems = cartItemService.getCartItemsByCodes(params);
    return processOrderCommon(sessionInfo, cartItems, orderFromView);
  }

//  @Override
  @Transactional(rollbackFor = Exception.class)
  public Order processDirectOrder(SessionInfo sessionInfo, Order orderFromView) throws Exception {
    // orderFromView에서 상품정보를 받아서 임시 CartItem 목록 생성
    List<OrderItem> orderItems = new ArrayList<>();
    if (orderFromView.getProductCodes() != null && orderFromView.getQuantities() != null) {
      for (int i = 0; i < orderFromView.getProductCodes().size(); i++) {
        OrderItem orderItem = new OrderItem();
        orderItem.setProductCode(orderFromView.getProductCodes().get(i));
        orderItem.setQuantity(orderFromView.getQuantities().get(i));
        // 단가 정보는 OrderItem 정보를 통해 가져오기
        OrderItem productInfo = getProductCode(orderFromView.getProductCodes().get(i));
        if (productInfo == null) {
          throw new Exception("상품 정보가 존재하지 않습니다. productCode=" + orderFromView.getProductCodes().get(i));
        }
        orderItem.setPrice(productInfo.getPrice());
        // 직접 구매이므로 쿠폰/포인트는 뷰에서 받은 값을 사용 (여기서는 기본값 0)
        orderItem.setCouponValue(0);
        orderItem.setSpentPoint(0);
        orderItems.add(orderItem);
      }
    }
//    return processOrderCommon(sessionInfo, orderItems, orderFromView);
    return null;
  }


}
