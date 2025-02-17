package com.sp.app.service;

import com.sp.app.mapper.CartItemMapper;
import com.sp.app.model.cart.CartItem;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class CartItemServiceImpl implements CartItemService {

  private final CartItemMapper cartItemMapper;

  @Transactional(rollbackFor = {Exception.class})
  @Override
  public void insertCartItem(CartItem cartItem, Long memberIdx) throws Exception {
    try {
      cartItem.setMemberIdx(memberIdx);

      Map<String, Object> params = new HashMap<>();
      params.put("memberIdx", memberIdx);
      params.put("productCode", cartItem.getProductCode());

      CartItem memberAndProduct = cartItemMapper.getCartItemByMemberAndProduct(params);

      if (memberAndProduct != null) {
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
      list = cartItemMapper.getCartListByMember(memberIdx);
      if (list == null) {
        return List.of();
      }
    } catch (Exception e) {
      log.info("getCartListByMember", e);
      throw e;
    }
    return list;
  }

  @Override
  public List<CartItem> getCartItemsByMemberAndProduct(Map<String, Object> params) throws Exception {
    List<CartItem> list = null;
    try {
      list = cartItemMapper.getCartItemsByMemberAndProduct(params);
      if (list == null) {
        return List.of();
      }
    } catch (Exception e) {
      log.info("getCartItemsByMemberAndProduct", e);
      throw e;
    }
    return list;
  }

  @Transactional(rollbackFor = {Exception.class})
  @Override
  public void updateCartItemQuantity(Map<String, Object> params) throws Exception {
    try {
      cartItemMapper.updateCartItemQuantity(params);
    } catch (Exception e) {
      log.info("updateCartItemQuantity", e);
      throw e;
    }
  }

  @Override
  public List<CartItem> getCartItemsByCodes(Map<String, Object> params) throws Exception {
    List<CartItem> list = null;
    try {
      list = cartItemMapper.getCartItemsByCodes(params);
      if (list == null) {
        return List.of();
      }
    } catch (Exception e) {
      log.info("getCartItemsByCodes", e);
      throw e;
    }
    return list;
  }

  @Transactional(rollbackFor = Exception.class)
  @Override
  public void deleteCartItems(Long memberIdx, List<Long> selectedCartItemCodes) throws Exception {
    try {
      Map<String, Object> params = new HashMap<>();
      params.put("memberIdx", memberIdx);
      params.put("selectedCodes", selectedCartItemCodes);
      cartItemMapper.deleteCartItems(params);
    } catch (Exception e) {
      log.error("deleteCartItems", e);
      throw e;
    }
  }

  @Override
  public void deleteCartItem(Long cartItemCode) throws Exception {
    try {
      cartItemMapper.deleteCartItem(cartItemCode);
    } catch (Exception e) {
      log.info("deleteCartItem", e);
      throw e;
    }
  }
}
