package com.sp.app.service;

import com.sp.app.model.cart.CartItem;

import java.util.List;
import java.util.Map;

public interface CartItemService {
  void insertCartItem(CartItem cartItem, Long memberIdx) throws Exception;  // 장바구니 항목 추가
  List<CartItem> getCartListByMember(Long memberIdx) throws Exception;  // 특정 회원의 장바구니 목록 조회
  List<CartItem> getCartItemsByMemberAndProduct(Map<String, Object> params) throws Exception;
  void deleteCartItem(Long cartItemCode) throws Exception;  // 장바구니 항목 삭제
//  CartItem getCartItemByMemberAndProduct(Map<String, Object> params) throws Exception;
  void updateCartItemQuantity(Map<String, Object> params) throws Exception;
  List<CartItem> getCartItemsByCodes(Map<String, Object> params) throws Exception;
  void deleteCartItems(Long memberIdx, List<Long> selectedCartItemCodes) throws Exception; // 선택된거 삭제


}
