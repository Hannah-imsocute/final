package com.sp.app.controller;

import com.sp.app.model.Order;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.ShippingInfo;
import com.sp.app.model.cart.CartItem;
import com.sp.app.service.CartItemService;
import com.sp.app.service.MemberService;
import com.sp.app.service.OrderService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order/*")
@RequiredArgsConstructor
@Slf4j
public class MemberOrderController {

  private final CartItemService cartItemService;
  private final MemberService memberService;
  private final OrderService orderService;

//  @GetMapping("form")
@RequestMapping(name = "form", method = {RequestMethod.GET, RequestMethod.POST})
public String orderForm(
    @RequestParam("productCode") List<Long> productCode,
    @RequestParam("quantity") List<Integer> quantity,
    @RequestParam("price") List<Integer> price,
    HttpSession session, Model model) throws Exception{

    Long memberIdx = getMemberIdx(session);

    String productOrderNumber = null; // 주문번호
    String productOrderName = ""; // 주문상품번호

    int totalPrice = 0; // 상품합
    int deliveryCharge = 0; // 배송비
    int totalPayment = 0;  // 결제할 금액(상품합 + 배송비)
    int totalSavedMoney = 0; // 적립금 총합
    int totalDiscountPrice = 0; // 총 할인액

    Map<String, Object> params = new HashMap<>();
    params.put("memberIdx", memberIdx);

    List<CartItem> cartItems = cartItemService.getCartItemsByMemberAndProduct(params);

    model.addAttribute("cartItems", cartItems);

    ShippingInfo shippingInfo = memberService.getShippingInfo(memberIdx);
    if(shippingInfo != null) {
      model.addAttribute("receiverName", shippingInfo.getReceiverName());
      model.addAttribute("addName", shippingInfo.getAddName());
      model.addAttribute("addTitle", shippingInfo.getAddTitle());
      model.addAttribute("addDetail", shippingInfo.getAddDetail());
      model.addAttribute("phone", shippingInfo.getPhone());
      model.addAttribute("firstAdd", shippingInfo.getFirstAdd());
    } else {
      model.addAttribute("receiverName", "");
      model.addAttribute("addName", "");
      model.addAttribute("addTitle", "");
      model.addAttribute("addDetail", "");
      model.addAttribute("phone", "");
      model.addAttribute("firstAdd", "");
    }
    return "order/form";
  }

  @PostMapping("payment")
  public String orderSubmit(Order dto, RedirectAttributes redirectAttributes, HttpSession session){

    try {
      SessionInfo info = (SessionInfo)session.getAttribute("member");

      dto.setMemberIdx(info.getMemberIdx());
      dto.setEmail(info.getEmail());

      orderService.insertOrder(dto);

//      String p = String.format("%,d", dto.getPayment());
      String p = String.format("%,d", "신한카드");

      StringBuilder sb = new StringBuilder();
      sb.append(info.getNickName()).append("님 상품을 구매해 주셔서 감사 합니다.<br>");
      sb.append("구매 하신 상품의 결제가 정상적으로 처리되었습니다.<br>").append("결제 금액 : <label class='fs-5 fw-bold text-primary'>").
          append(p).append("</label>원");

      redirectAttributes.addFlashAttribute("title", "상품 결제 완료");
      redirectAttributes.addFlashAttribute("message", sb.toString());

      return "redirect:/order/complete";

    } catch (Exception e) {
      log.info("orderSubmit : ", e);
    }
    return "redirect:/";
  }

  private static Long getMemberIdx(HttpSession session) {
    SessionInfo member = (SessionInfo) session.getAttribute("member");
    return member.getMemberIdx();
  }


}
