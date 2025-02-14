package com.sp.app.mapper;

import com.sp.app.model.*;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface OrderMapper {

  // 주문번호(혹은 주문 코드) 조회: 가장 최신 주문번호 또는 최대 주문번호를 가져오는 경우
  long getLatestOrderCode();

  // 주문(결제) 등록: 주문 정보를 DB에 삽입하는 경우
  void insertOrder(Order order) throws SQLException;
  // 또는 "placeOrder"로 주문 접수를 의미할 수도 있음.

  // 결제 내역 등록: 결제 정보를 기록할 경우
  void insertPayment(Payment payment) throws SQLException;
  // 또는 registerPayment()

  // 주문 상세 정보 등록: 주문에 포함된 개별 상품(주문 상세) 정보 등록
  void insertOrderDetail(OrderItem orderItem) throws SQLException;
  // 또는 registerOrderDetail()

  // 배송지 등록: 배송 정보를 등록할 경우
  void insertShippingAddress(ShippingInfo shippingInfo) throws SQLException;

  // 배송지 수정

  void updateShippingAddress(ShippingInfo shippingInfo) throws SQLException;
  // 포인트 등록: 사용자의 포인트 내역 등록
  void insertUserPoint(MemberPoint userPoint) throws SQLException;
  // 또는 registerUserPoint()

  // 유저의 가장 최근 포인트 조회: 특정 유저의 최신 포인트 내역을 가져오는 경우
  MemberPoint getLatestUserPoint(long userId);
  // 또는 selectLatestUserPoint()

  // 주문 내역 상세 리스트 조회: 주문의 여러 상세 정보(리스트)를 조회할 경우
  List<Order> getOrderDetailList(Map<String, Object> params);
  // params에는 userId, 기간 등 다양한 검색 조건이 들어갈 수 있음.

  // 주문 상세 정보 조회: 특정 주문 상세 정보를 조회할 경우
  Order getOrderDetail(long orderDetailId);
  // 또는 selectOrderDetail()

  // 상품 정보 조회: 주문에 포함된 상품 정보를 조회할 경우
  MainProduct getProduct(long productId);

  // 옵션 상세 리스트 조회: 상품에 관련된 옵션(예, 색상, 사이즈 등) 리스트 조회
//  List<OptionDetail> getOptionDetailList(long productId);

  // 옵션 상세 정보 조회: 특정 옵션의 상세 정보 조회
//  OptionDetail getOptionDetail(long optionDetailId);

  // 판매 개수만큼 재고 감소: 주문 후 재고 수량을 줄이는 경우
  void decreaseProductStock(long productId, int quantity) throws SQLException;


}
