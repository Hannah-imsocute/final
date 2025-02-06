package com.sp.app.service;

import com.sp.app.mapper.CartItemMapper;
import com.sp.app.mapper.MemberMapper;
import com.sp.app.model.cart.CartItem;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class CartItemServiceImpl implements CartItemService {

  private final MemberMapper memberMapper;
  private final CartItemMapper cartItemMapper;

  @Override
  public void insertCartItem(CartItem cartItem, Long memberIdx) throws Exception {
    try {
      cartItem.setMemberIdx(memberIdx);

      Map<String, Object> params = new HashMap<>();
      params.put("memberIdx", memberIdx);
      params.put("productCode", cartItem.getProductCode());

      CartItem memberAndProduct = cartItemMapper.getCartItemByMemberAndProduct(params);

      if(memberAndProduct != null) {
        // 회원 장바구니에 상품 코드가 존재 한다면
        int newQuantity = memberAndProduct.getQuantity() + cartItem.getQuantity();
        Map<String, Object> updateParams = new HashMap<>();
        updateParams.put("cartItemCode", memberAndProduct.getCartItemCode());
        updateParams.put("quantity", newQuantity);

        cartItemMapper.updateCartItemQuantity(updateParams);
      } else {
        cartItemMapper.insertCartItem(cartItem);
      }
    } catch (Exception e) {
     log.info("insertCartItem", e);
     throw e;
    }
  }

  @Override
  public List<CartItem> getCartListByMember(Long memberIdx) throws Exception {
    List<CartItem> list = null;

    try {
      list = Objects.requireNonNull(cartItemMapper.getCartListByMember(memberIdx));
    } catch (NullPointerException e) {
      return new ArrayList<>();
    } catch (Exception e) {
      log.info("getCartListByMember", e);
    }

    return list;
  }

  @Override
  public void deleteCartItem(Long cartItemCode) throws Exception {
    try {
      cartItemMapper.deleteCartItem(cartItemCode);
    } catch (Exception e) {
     log.info("deleteCartItem", e);
    }
  }
}


/*
package com.sp.app.service;

import com.sp.app.mapper.CartItemMapper;
import com.sp.app.mapper.MemberMapper;
import com.sp.app.model.cart.CartItem;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class CartItemServiceImpl implements CartItemService {

  private final MemberMapper memberMapper;
  private final CartItemMapper cartItemMapper;

  @Override
  public void insertCartItem(CartItem cartItem, String email) throws Exception {
    Long memberIdx = memberMapper.getMemberIdx(email);
    cartItem.setMemberIdx(memberIdx);
    insertCartItem(cartItem, memberIdx);
  }

  @Override
  public void insertCartItem(CartItem cartItem, Long memberIdx) throws Exception {
    try {
      cartItem.setMemberIdx(memberIdx);

      // 기존 장바구니 항목 확인 (@Param으로 전달하므로 개별 파라미터 사용)
      CartItem existingItem = cartItemMapper.getCartItemByMemberAndProduct(
          memberIdx, cartItem.getProductcode());

      if (existingItem != null) {
        // 기존 항목이 있다면 수량 업데이트 (기존 수량 + 추가 수량)
        int newQuantity = existingItem.getQuantity() + cartItem.getQuantity();
        cartItemMapper.updateCartItemQuantity(existingItem.getCartItemCode(), newQuantity);
      } else {
        // 신규 항목이면 삽입
        cartItemMapper.insertCartItem(cartItem);
      }
    } catch (Exception e) {
      log.error("insertCartItem error", e);
      throw e;
    }
  }

  @Override
  public List<CartItem> getCartListByMember(Long memberIdx) throws Exception {
    List<CartItem> list = null;
    try {
      list = Objects.requireNonNull(cartItemMapper.getCartListByMember(memberIdx));
    } catch (Exception e) {
      log.error("getCartListByMember error", e);
    }
    return list;
  }

  @Override
  public void deleteCartItem(Long cartItemCode) throws Exception {
    try {
      cartItemMapper.deleteCartItem(cartItemCode);
    } catch (Exception e) {
      log.error("deleteCartItem error", e);
      throw e;
    }
  }
}
*/