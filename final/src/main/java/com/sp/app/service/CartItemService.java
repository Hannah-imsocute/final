package com.sp.app.service;

import com.sp.app.model.cart.CartItem;

import java.util.List;

public interface CartItemService {
//  void insertCartItem(CartItem cartItem, String email) throws Exception;  // 장바구니 항목 추가
  void insertCartItem(CartItem cartItem, Long memberIdx) throws Exception;  // 장바구니 항목 추가
  List<CartItem> getCartListByMember(Long memberIdx) throws Exception;  // 특정 회원의 장바구니 목록 조회
  void deleteCartItem(Long cartItemCode)throws Exception;  // 장바구니 항목 삭제
}
