package com.sp.app.controller;

import com.sp.app.model.SessionInfo;
import com.sp.app.model.cart.CartItem;
import com.sp.app.service.CartItemService;
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

  // 장바구니 리스트
  @GetMapping("list")
  public String getCartListByMember(HttpSession session, Model model) throws Exception {
    try {
      Long memberIdx = getMemberIdx(session);

      Map<String, Object> params = new HashMap<>();
      params.put("memberIdx", memberIdx);

      List<CartItem> list = cartItemService.getCartItemsByMemberAndProduct(params);
      model.addAttribute("list", list);
    } catch (Exception e) {
      log.info("getCartListByMember", e);
    }
    return "cart/main";
  }

//  @PostMapping("add")
  public String addCartItem(
      @RequestParam("productCode") Long productCode,
      @RequestParam("quantity") Integer quantity,
      @RequestParam("price") Integer price, HttpSession session) throws Exception {

    Long memberIdx = getMemberIdx(session);

    CartItem cartItem = new CartItem();
    cartItem.setProductCode(productCode);
    cartItem.setQuantity(quantity);
    cartItem.setPrice(price);

    cartItemService.insertCartItem(cartItem, memberIdx);

    return "redirect:/cart/list";
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

  /*
  ResponseEntity 쓰면 body message 쉽게 가능
  @PostMapping("updateQuantity1")
  public ResponseEntity<?> updateQuantityAjax(@RequestParam("cartItemCode") Long cartItemCode,
                                              @RequestParam("quantity") Integer quantity,
                                              HttpSession session) {
    Map<String, Object> response = new HashMap<>();
    try {
      Map<String, Object> params = new HashMap<>();
      params.put("cartItemCode", cartItemCode);
      params.put("quantity", quantity);
      cartItemService.updateCartItemQuantity(params);
      response.put("status", "success");
      return ResponseEntity.ok(response);
    } catch (Exception e) {
      log.info("updateQuantity", e);
      response.put("status", "error");
      response.put("message", e.getMessage());
      return ResponseEntity.status(500).body(response);
    }
  }
   */



  // 장바구니 삭제
  @PostMapping("delete")
  public String deleteCartItem(@RequestParam("cartItemCode") Long cartItemCode) throws Exception {
    try {
      cartItemService.deleteCartItem(cartItemCode);
      return "redirect:/cart/list";
    } catch (Exception e) {
      log.info("delete", e);
    }
    return "redirect:/cart/list";
  }

  // Session 에서 회원코드 반환
  private static Long getMemberIdx(HttpSession session) {
    SessionInfo member = (SessionInfo) session.getAttribute("member");
    return member.getMemberIdx();
  }
}
