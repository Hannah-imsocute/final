package com.sp.app.controller;

import com.sp.app.model.Order;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.ShippingInfo;
import com.sp.app.model.cart.CartItem;
import com.sp.app.service.CartItemService;
import com.sp.app.service.OrderService;
import com.sp.app.service.MemberService;
import com.sp.app.service.ShippingService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order/*")
@RequiredArgsConstructor
@Slf4j
public class MemberOrderController1 {

  private final MemberService memberService;
  private final OrderService orderService;
  private final CartItemService cartItemService;
  private final ShippingService shippingService;

  @GetMapping("form")
  public String orderForm(HttpSession session, Model model) throws Exception {
    SessionInfo info = (SessionInfo) session.getAttribute("member");

    if (info == null) {
      return "redirect:/login";
    }

    long memberIdx = info.getMemberIdx();

    Map<String, Object> params = new HashMap<>();
    params.put("memberIdx", memberIdx);

    List<CartItem> cartItems = cartItemService.getCartItemsByMemberAndProduct(params);

    model.addAttribute("cartItems", cartItems);

    ShippingInfo shippingInfo = memberService.getShippingInfo(memberIdx);
    List<ShippingInfo> list = shippingService.getShippingInfo(memberIdx);
    model.addAttribute("shippingAddresses", list);
    if(shippingInfo != null) {
      model.addAttribute("receiverName", shippingInfo.getReceiverName());
      model.addAttribute("addName", shippingInfo.getAddName());
      model.addAttribute("addTitle", shippingInfo.getAddTitle());
      model.addAttribute("addDetail", shippingInfo.getAddDetail());
      model.addAttribute("phone", shippingInfo.getPhone());
      model.addAttribute("firstAdd", shippingInfo.getFirstAdd());

    }

    return "order/formtest";
  }

  @PostMapping("submit")
  public String submitOrder(HttpSession session, Model model) {
    try {
      SessionInfo info = (SessionInfo) session.getAttribute("member");
      if (info == null) {
        return "redirect:/login";
      }
      Order processedOrder = orderService.processOrder(info);
      model.addAttribute("order", processedOrder);
      return "order/complete";
    } catch (Exception e) {
      log.error("주문 처리 중 오류 발생", e);
      model.addAttribute("Message", "주문 처리 중 오류 발생..");
      return "redirect:/";
    }
  }

/*
 @GetMapping("addr")
  public String addressForm(@RequestParam("receiverName") String receiverName,
                            @RequestParam("addName") String addName,
                            @RequestParam@)

                            */

  @GetMapping("addr")
  public String addressForm(ShippingInfo info) {

    return "redirect:/order/formtest";
  }

  @PostMapping("addr")
  @ResponseBody
  public Map<String, Object> addressSubmit(
          @ModelAttribute("infolist") ShippingInfo shippingInfo,
          HttpSession session) {
    Map<String, Object> map = new HashMap<>();
    try {
      SessionInfo info = (SessionInfo) session.getAttribute("member");
      long memberIdx = info.getMemberIdx();
      if(memberIdx == 0) {
        log.error("회원값없음", memberIdx);
      }

      shippingInfo.setMemberIdx(memberIdx);

      // 배송지 등록
      orderService.insertShippingAddress(shippingInfo);

      List<ShippingInfo> list = shippingService.getShippingInfo(memberIdx);

      map.put("status", "success");
      map.put("shippingAddresses", list);
    } catch(Exception e) {
      map.put("status", "error");
      map.put("message", e.getMessage());
    }
    return map;
  }

 /* @PostMapping("/selectShippingAddress")
  public ResponseEntity<String> selectShippingAddress(
          @RequestParam String receiverName,
          @RequestParam String addTitle,
          @RequestParam String addDetail,
          @RequestParam String phone,
          HttpSession session) {

    ShippingInfo selectedAddress = new ShippingInfo();
    selectedAddress.setReceiverName(receiverName);
    selectedAddress.setAddTitle(addTitle);
    selectedAddress.setAddDetail(addDetail);
    selectedAddress.setPhone(phone);

    session.setAttribute("selectedShippingAddress", selectedAddress);

    return ResponseEntity.ok("배송지가 선택되었습니다.");
  }*/


}