package com.sp.app.mapper;

import com.sp.app.model.cart.CartItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface CartItemMapper {
  void insertCartItem(CartItem cartItem) throws SQLException;  // 장바구니 항목 추가
  List<CartItem> getCartListByMember(Long memberIdx) throws SQLException;  // 특정 회원의 장바구니 목록 조회
  void deleteCartItem(Long cartItemCode)throws SQLException;  // 장바구니 항목 삭제
//  CartItem getCartItemByMemberAndProduct(@Param("memberIdx") Long memberIdx, @Param("productcode") Long productcode);
//  void updateCartItemQuantity(@Param("cartItemCode") Long cartItemCode, @Param("quantity") int quantity);

  /*
  { "memberIdx": memberIdx, "productcode": productcode }
  { "cartItemCode": cartItemCode, "quantity": quantity }
  */

  CartItem getCartItemByMemberAndProduct(Map<String, Object> params);
  void updateCartItemQuantity(Map<String, Object> params);

}
