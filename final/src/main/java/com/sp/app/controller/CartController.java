package com.sp.app.controller;

import com.sp.app.model.Coupon;
import com.sp.app.model.Order;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.cart.CartItem;
import com.sp.app.service.CartItemService;
import com.sp.app.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/cart/*")
@RequiredArgsConstructor
@Slf4j
public class CartController {

  private final CartItemService cartItemService;
  private final OrderService orderService;

  // 장바구니 리스트
  @GetMapping("list")
  public String getCartListByMember(HttpSession session, Model model) throws Exception {
    try {
      Long memberIdx = getMemberIdx(session);

      Map<String, Object> params = new HashMap<>();
      params.put("memberIdx", memberIdx);

      List<CartItem> list = cartItemService.getCartItemsByCodes(params);
      for (CartItem cartItem : list) {
        model.addAttribute("cartItemCode", cartItem.getCartItemCode());
      }
      List<Coupon> couponList = orderService.getCouponList(memberIdx);
      model.addAttribute("cartList", list); //
      model.addAttribute("couponList", couponList); //

    } catch (Exception e) {
      log.info("getCartListByMember", e);
    }
    return "cart/main";
  }


  @PostMapping("add")
  public String addCartItem(@ModelAttribute("cartItem") CartItem cartItem, HttpSession session) throws Exception {

    try {
      Long memberIdx = getMemberIdx(session);

      cartItemService.insertCartItem(cartItem, memberIdx);
    } catch (Exception e) {
      log.info("addCartItem", e);
    }
    return "redirect:/cart/list";
  }

  @PostMapping("updateQuantity")
  public String updateQuantity(@RequestParam("cartItemCode") Long cartItemCode,
                               @RequestParam("quantity") Integer quantity,
                               HttpSession session) throws Exception {
    try {
      Map<String, Object> params = new HashMap<>();
      params.put("cartItemCode", cartItemCode);
      params.put("quantity", quantity);
      cartItemService.updateCartItemQuantity(params);
    } catch (Exception e) {
      log.info("updateQuantity", e);
      throw e;
    }
    return "redirect:/cart/list";
  }

  @PostMapping("updateQuantity1")
  @ResponseBody // AJAX-JSON
  public Map<String, Object> updateQuantityAjax(@RequestParam("cartItemCode") Long cartItemCode,
                                                @RequestParam("quantity") Integer quantity,
                                                HttpSession session) {
    Map<String, Object> result = new HashMap<>();
    try {
      Map<String, Object> params = new HashMap<>();
      params.put("cartItemCode", cartItemCode);
      params.put("quantity", quantity);
      cartItemService.updateCartItemQuantity(params);
      result.put("status", "success");
    } catch (Exception e) {
      log.info("updateQuantity", e);
      result.put("status", "error");
      result.put("message", e.getMessage());
    }
    return result;
  }


  // 장바구니 삭제
  @PostMapping("delete")
  @ResponseBody
  public Map<String, Object> deleteCartItem1(@RequestParam("cartItemCode") Long cartItemCode) throws Exception {
    Map<String, Object> params = new HashMap<>();
    try {
      cartItemService.deleteCartItem(cartItemCode);
      params.put("status", "success");
    } catch (Exception e) {
      params.put("status", "error");
      params.put("message", "상품을 삭제하실 수 없습니다.");
      log.info("delete", e);
    }
    return params;
  }

  // 장바구니 선택 삭제
  @PostMapping("deleteSelected")
  @ResponseBody
  public Map<String, Object> deleteSelectedCartItems(@RequestParam("cartItemCode") List<Long> cartItemCodes) throws Exception {
    Map<String, Object> result = new HashMap<>();
    try {
      for(Long cartItemCode : cartItemCodes) {
        cartItemService.deleteCartItem(cartItemCode);
      }
      result.put("status", "success");
    } catch(Exception e) {
      result.put("status", "error");
      result.put("message", "선택된 상품을 삭제할 수 없습니다.");
      log.info("deleteSelectedCartItems", e);
    }
    return result;
  }

  // Session 에서 회원코드 반환
  private static Long getMemberIdx(HttpSession session) {
    SessionInfo member = (SessionInfo) session.getAttribute("member");
    return member.getMemberIdx();
  }
}
