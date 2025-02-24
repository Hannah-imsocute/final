package com.sp.app.service;

import com.sp.app.mapper.OrderItemMapper;
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
  private final OrderItemMapper orderItemMapper;

  private static AtomicLong count = new AtomicLong(0);

  private final CartItemService cartItemService;
  private final CouponService couponService;
  private final PointService pointService;


  // 주문번호 생성
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


  // 주문 테이블 저장
  @Transactional(rollbackFor = Exception.class)
  @Override
  public void insertOrder(Order dto) throws Exception {
    try {
      // 주문 정보 저장
      orderMapper.insertOrder(dto);

      //  상세 주문 정보 저장
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
          dto.setOrderState(1);

          // 주문 상세 등록
          orderMapper.insertOrderDetail(dto.getOrderItem());
        }
      }

      //  포인트 사용 시 포인트 내역 등록
      if (dto.getSpentPoint() > 0) {
        MemberPoint memberPoint = new MemberPoint();
        memberPoint.setMemberIdx(dto.getMemberIdx());
        memberPoint.setOrderCode(dto.getOrderCode());
        memberPoint.setUsedAmount(dto.getSpentPoint());
        memberPoint.setBalance(-dto.getSpentPoint());
        // 날짜/시간 포맷 예시는 필요에 맞게 조정
        memberPoint.setUsedDate(java.time.LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        memberPoint.setExpireDate(dto.getExpireDate());

        orderMapper.insertUserPoint(memberPoint);
      }

      // 쿠폰 사용 처리
      Coupon coupon = dto.getCoupon();
      if (coupon != null && coupon.getCouponCode() != null) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberIdx", dto.getMemberIdx());
        map.put("couponCode", coupon.getCouponCode());

        // 쿠폰 삭제
        couponService.deleteCouponUsed(map);
        // 사용 이력 등록
        couponService.insertCouponUsed(map);

        log.debug("쿠폰 사용 처리 완료. memberIdx={}, couponCode={}", dto.getMemberIdx(), coupon.getCouponCode());
      }

      // 배송 정보 등록
      dto.getShippingInfo().setState("상품준비중");
      if (dto.getShippingInfo().getRequire() == null) {
        dto.getShippingInfo().setRequire("");
      }
      shippingMapper.insertPackage(dto.getShippingInfo());

    } catch (Exception e) {
      log.info("insertOrder() ", e);
      throw e; // rollback
    }
  }

  /**
   * 결제 정보
   */
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

  /**
   * 주문 상세 정보
   */
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

  /**
   * 배송 주소
   */
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

  /**
   * 포인트 사용/적립
   */
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

  /**
   * 가장 최근 포인트 내역
   */
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

  /**
   * 쿠폰 리스트
   */
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

  /**
   * 특정 주문코드의 상세 내역
   */
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

  /**
   * 주문 상품 목록
   */
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

  /**
   * 특정 주문 상세
   */
  @Override
  public Order getOrderDetail(long orderDetailId) {
    return null;
  }

  /**
   * 특정 상품 정보
   */
  @Override
  public MainProduct getProduct(long productId) {
    return null;
  }

  /**
   * 상품 코드로 상품(주문) 정보 가져오기
   */
  @Override
  public OrderItem getProductCode(long productId) {
    OrderItem dto = null;
    try {
      dto = orderMapper.getProduct(productId);
    } catch (Exception e) {
      log.info("getProductCode() ", e);
    }
    return dto;
  }

//  중복되는 주문 처리 메서드

  /**
   * 실제 주문 처리를 수행하는 공통 메서드
   * - 장바구니 아이템 리스트와 뷰에서 전달받은 Order 객체(쿠폰/포인트/배송정보 등)를 합쳐서
   *   결제/주문/배송 처리를 수행한다.
   */
  @Transactional(rollbackFor = Exception.class)
  protected Order processOrderInternal(SessionInfo sessionInfo, List<CartItem> cartItems, Order orderFromView, Payment payment) throws Exception {
    if (cartItems == null || cartItems.isEmpty()) {
      throw new Exception("장바구니가 비어 있습니다. (혹은 상품이 선택되지 않았습니다.)");
    }

    //  총 결제 금액 계산
    int overallNetPay = 0;
    for (CartItem cartItem : cartItems) {
      int totalPrice = cartItem.getQuantity() * cartItem.getPrice();
      int shipping = (totalPrice >= 20000) ? 0 : 3000;
      int couponValueForItem = (cartItem.getCouponValue() != null) ? cartItem.getCouponValue() : 0;
      int spentPointForItem = (cartItem.getSpentPoint() != null) ? cartItem.getSpentPoint() : 0;

      // 총합 = 상품금액 + 배송비 - 쿠폰할인 - 포인트사용
      int netPay = totalPrice + shipping - couponValueForItem - spentPointForItem;
      overallNetPay += netPay;
    }

    // 주문코드 생성
    String orderCode = getLatestOrderCode();

    //  추가 정보(뷰에서 넘어온 쿠폰, 포인트, 결제수단 등) 반영
//    String payment = (orderFromView != null && orderFromView.getPayment() != null)
//        ? orderFromView.getPayment() : "카드";

    int usedPoint = (orderFromView != null && orderFromView.getSpentPoint() != null)
        ? orderFromView.getSpentPoint() : 0;

    int couponVal = (orderFromView != null && orderFromView.getCouponValue() != null)
        ? orderFromView.getCouponValue() : 0;

    int finalNetPay = overallNetPay - couponVal - usedPoint;
    if (finalNetPay < 0) finalNetPay = 0;

    Order order = Order.builder()
        .memberIdx(sessionInfo.getMemberIdx())
        .email(sessionInfo.getEmail())
        .orderDate(java.time.LocalDateTime.now().toString())  // 예시
        .orderCode(orderCode)
        .totalPrice(overallNetPay)
        .couponCode((orderFromView != null) ? orderFromView.getCouponCode() : null)
        .couponValue(couponVal)
        .spentPoint(usedPoint)
        .netPay(finalNetPay)
//        .payment(payment)
        .shippingInfo((orderFromView != null) ? orderFromView.getShippingInfo() : null)
        .build();

    orderMapper.insertOrder(order);

    for (CartItem cartItem : cartItems) {
      OrderItem orderItem = OrderItem.builder()
          .orderCode(orderCode)
          .productCode(cartItem.getProductCode())
          .options(cartItem.getCartOption())  // 옵션 정보
          .priceForeach(cartItem.getPrice())
          .quantity(cartItem.getQuantity())
          .price(cartItem.getQuantity() * cartItem.getPrice())
          .shipping((cartItem.getQuantity() * cartItem.getPrice() >= 20000) ? 0 : 3000)
          .orderState(0)
          .build();

      orderMapper.insertOrderDetail(orderItem);

      // 배송 정보 등록 (아이템 단위)
      if (order.getShippingInfo() != null) {
        ShippingInfo shipping = order.getShippingInfo();
        shipping.setItemCode(orderItem.getItemCode());
        shipping.setMemberIdx(order.getMemberIdx());
        shipping.setState("상품준비중");
        shipping.setProductCode(orderItem.getProductCode());
        shippingMapper.insertPackage(shipping);
      }
    }


    payment.setOrderCode(orderCode);
    payment.setMemberIdx(order.getMemberIdx());
    payment.setByMethod(payment.getByMethod()); // 결제수단
    payment.setCardNumber(payment.getCardNumber());
    payment.setProvider(payment.getProvider()); // 카드사
    payment.setConfirmCode(payment.getConfirmCode());
    payment.setConfirmDate(payment.getConfirmDate());

    orderMapper.insertPayment(payment);

    List<Long> cartItemIds = new ArrayList<>();
    for (CartItem c : cartItems) {
      cartItemIds.add(c.getCartItemCode());
    }
    cartItemService.deleteCartItems(sessionInfo.getMemberIdx(), cartItemIds);

    // 만약 사용된 포인트가 있다면 포인트 이력 등록
    if (order.getSpentPoint() != null && order.getSpentPoint() > 0) {
      Long pNum = pointService.getPointSaveNum(order.getMemberIdx());

      MemberPoint memberPoint = MemberPoint.builder()
          .memberIdx(order.getMemberIdx())
          .pointSaveNum(pNum)
          .orderCode(order.getOrderCode())
          .usedAmount(order.getSpentPoint())
          .balance(-order.getSpentPoint()) // 차감된 포인트
          .usedDate(java.time.LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")))
          .build();

      Map<String, Object> map = new HashMap<>();
      map.put("pointSaveNum", memberPoint.getPointSaveNum()); // 어느 적립 레코드에서 차감?
      map.put("memberIdx", order.getMemberIdx());
      map.put("usedAmount", memberPoint.getUsedAmount());
      pointService.updatePointValid1(map);
      pointService.updatePointValid2(map);
      pointService.insertPointHistory(memberPoint);
    }

    if (orderFromView != null) {
      Coupon coupon = orderFromView.getCoupon();
      if (coupon != null && coupon.getCouponCode() != null && !coupon.getCouponCode().trim().isEmpty()) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberIdx", orderFromView.getMemberIdx());
        map.put("couponCode", coupon.getCouponCode());

        couponService.deleteCouponUsed(map);
        couponService.insertCouponUsed(map);

        log.debug("쿠폰 사용 처리. memberIdx={}, couponCode={}", orderFromView.getMemberIdx(), coupon.getCouponCode());
      }
    }
    return order;
  }

//  /**
//   * [기존] 전체 장바구니 아이템 구매 로직
//   */
//  @Override
//  @Transactional(rollbackFor = Exception.class)
//  public Order processOrder(SessionInfo sessionInfo) throws Exception {
//    // 1) 전체 장바구니 가져오기
//    List<CartItem> cartItems = cartItemService.getCartListByMember(sessionInfo.getMemberIdx());
//    // 2) 공통 메서드 호출 (orderFromView = null)
//    return processOrderInternal(sessionInfo, cartItems, null);
//  }

  @Override
  @Transactional(rollbackFor = Exception.class)
  public Order processOrder(SessionInfo sessionInfo, Order order, Payment payment) throws Exception {
    return processDirectOrder(sessionInfo, order, payment);
  }

  /**
   *  선택된 장바구니 아이템 구매
   */
  @Override
  @Transactional(rollbackFor = Exception.class)
  public Order processOrder(SessionInfo sessionInfo, List<Long> selectedCartItemCodes, Payment payment) throws Exception {
    Map<String, Object> params = new HashMap<>();
    params.put("memberIdx", sessionInfo.getMemberIdx());
    params.put("selectedCodes", selectedCartItemCodes);

    // 선택된 장바구니 아이템 조회
    List<CartItem> cartItems = cartItemService.getCartItemsByCodes(params);
    //  공통 메서드 호출 (orderFromView = null)
    return processOrderInternal(sessionInfo, cartItems, null, payment);
  }

  /**
   * [개선] 선택된 장바구니 아이템 구매 + 사용자 입력(OrderFromView) 반영
   */
  @Override
  @Transactional(rollbackFor = Exception.class)
  public Order processOrder(SessionInfo sessionInfo, List<Long> selectedCartItemCodes, Order orderFromView, Payment payment) throws Exception {
    Map<String, Object> params = new HashMap<>();
    params.put("memberIdx", sessionInfo.getMemberIdx());
    params.put("selectedCodes", selectedCartItemCodes);

    // 1) 선택된 장바구니 아이템 조회
    List<CartItem> cartItems = cartItemService.getCartItemsByCodes(params);
    // 2) 공통 메서드 호출 (orderFromView 적용)
    return processOrderInternal(sessionInfo, cartItems, orderFromView, payment);
  }

  /**
   * [직접 구매] 장바구니 없이 바로 구매
   * - orderFromView에서 상품/옵션 정보를 받아와 CartItem 형태로 임시 구성하여 구매 처리
   */
  @Transactional(rollbackFor = Exception.class)
  public Order processDirectOrder(SessionInfo sessionInfo, Order orderFromView, Payment payment) throws Exception {
    if (orderFromView == null || orderFromView.getProductCodes() == null || orderFromView.getQuantities() == null) {
      throw new Exception("주문 정보가 부족합니다. (직접 구매)");
    }

    // OrderFromView의 상품 정보를 CartItem 형태로 변환
    List<CartItem> cartItems = new ArrayList<>();
    for (int i = 0; i < orderFromView.getProductCodes().size(); i++) {
      Long productCode = orderFromView.getProductCodes().get(i);
      Integer quantity = orderFromView.getQuantities().get(i);

      OrderItem productInfo = getProductCode(productCode);
      if (productInfo == null) {
        throw new Exception("상품 정보가 존재하지 않습니다. productCode=" + productCode);
      }

      CartItem cartItem = CartItem.builder()
          .cartItemCode(0L) // 임시 (DB에 저장되는 장바구니 아니므로)
          .memberIdx(sessionInfo.getMemberIdx())
          .productCode(productCode)
          .quantity(quantity)
          .price(productInfo.getPrice()) // 단가
          .cartOption(productInfo.getOptions())
          .build();

      cartItems.add(cartItem);


    }

    return processOrderInternal(sessionInfo, cartItems, orderFromView, payment);
  }

}
