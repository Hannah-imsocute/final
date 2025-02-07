package com.sp.app.mapper;

import com.sp.app.model.cart.CartItem;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface CartItemMapper {
  void insertCartItem(CartItem cartItem) throws SQLException;  // 장바구니 항목 추가
  List<CartItem> getCartListByMember(Long memberIdx) throws SQLException;  // 특정 회원의 장바구니 목록 조회
  void deleteCartItem(Long cartItemCode)throws SQLException;  // 장바구니 항목 삭제
  CartItem getCartItemByMemberAndProduct(Map<String, Object> params);
  List<CartItem> getCartItemsByMemberAndProduct(Map<String, Object> params) throws Exception;
  void updateCartItemQuantity(Map<String, Object> params);
}
