package com.sp.app.controller;

import com.sp.app.model.Order;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.cart.CartItem;
import com.sp.app.service.CartItemService;
import com.sp.app.service.MemberService;
import com.sp.app.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/order/*")
@RequiredArgsConstructor
@Slf4j
public class MemberOrderController1 {

  private final MemberService memberService;
  private final OrderService orderService;
  private final CartItemService cartItemService;

  /*
   주문 시 여러 상품(또는 장바구니의 여러 항목)을 한 번에 처리
  */
  /*
  @RequestMapping(name = "form", method = {RequestMethod.GET, RequestMethod.POST})
  public String orderForm(Order orderRequest, HttpSession session, Model model) throws Exception {
    try {
      SessionInfo info = (SessionInfo) session.getAttribute("member");

//      List<Order> list = orderRequest.getOrders();
//      List<Order> list = cartItemService.getCartListByMember(info.getMemberIdx())
      List<CartItem> list = cartItemService.getCartListByMember(info.getMemberIdx());
      int overallNetPay = 0;

      for (CartItem dto : list) {
        int totalPrice = dto.getQuantity() * dto.getPrice();
        dto.setTotalPrice(totalPrice);

        // 배송비 결정: 총금액이 20,000원 이상이면 무료, 아니면 3,000원
        if(totalPrice >= 20000) {
          dto.setShipping(0);
        } else {
          dto.setShipping(3000);
        }

        // (상품금액 + 배송비 - 쿠폰할인 - 사용 포인트)
        int netPay = totalPrice + dto.getShipping() - dto.getCouponValue() - dto.getSpentPoint();
        dto.setNetPay(netPay);
        overallNetPay += netPay;

        dto.setMemberIdx(info.getMemberIdx());
        dto.setEmail(info.getEmail());
      }

      model.addAttribute("orderItems", list);
      model.addAttribute("overallNetPay", overallNetPay);

      return "order/formtest";
    } catch (Exception e) {
      log.error("orderForm", e);
    }

    return "redirect:/";
  }
   */
}
