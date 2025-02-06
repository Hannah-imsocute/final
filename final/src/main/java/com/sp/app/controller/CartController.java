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

import java.util.List;

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

      List<CartItem> list = cartItemService.getCartListByMember(memberIdx);

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

  // 장바구니 삭제
  @PostMapping("delete")
  public String deleteCartItem(@RequestParam("cartItemCode") Long cartItemCode) throws Exception {
    try {
      cartItemService.deleteCartItem(cartItemCode);
      return "redirect:/cart/list";
    } catch (Exception e) {
      throw new RuntimeException(e);
    }
  }

  // Session 에서 회원코드 반환
  private static Long getMemberIdx(HttpSession session) {
    SessionInfo member = (SessionInfo) session.getAttribute("member");
    return member.getMemberIdx();
  }
}
