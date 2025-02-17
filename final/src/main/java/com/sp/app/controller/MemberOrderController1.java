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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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

//  @GetMapping("form")
  public String orderForm(
          HttpSession session, Model model) throws Exception {
    SessionInfo info = (SessionInfo) session.getAttribute("member");

    if (info == null) {
      return "redirect:/login";
    }

    long memberIdx = info.getMemberIdx();

    Map<String, Object> params = new HashMap<>();
    params.put("memberIdx", memberIdx);

    List<CartItem> cartItems = cartItemService.getCartItemsByMemberAndProduct(params);

    model.addAttribute("cartItems", cartItems);

    ShippingInfo addressInfo = (ShippingInfo) session.getAttribute("memberAddress");
    if (addressInfo == null) {
      addressInfo = memberService.getShippingInfo(memberIdx);
    }

    if (addressInfo != null) {
      model.addAttribute("receiverName", addressInfo.getReceiverName());
      model.addAttribute("addName", addressInfo.getAddName());
      model.addAttribute("addTitle", addressInfo.getAddTitle());
      model.addAttribute("addDetail", addressInfo.getAddDetail());
      model.addAttribute("phone", addressInfo.getPhone());
      model.addAttribute("firstAdd", addressInfo.getFirstAdd());
    }

    List<ShippingInfo> list = shippingService.getShippingInfo(memberIdx);
    model.addAttribute("shippingAddresses", list);
    return "order/formtest";
  }


//  새로 추가
  @GetMapping("form")
  public String orderForm(
          @RequestParam(value = "selectedItems", required = false) String selectedItems,
          HttpSession session, Model model, Order order) throws Exception {

    SessionInfo info = (SessionInfo) session.getAttribute("member");
    if (info == null) {
      return "redirect:/login";
    }
//    model.addAttribute("order", order);
    long memberIdx = info.getMemberIdx();

    List<CartItem> cartItems;
    if (selectedItems != null && !selectedItems.isEmpty()) {
      // 1,2,3 ,-> 로  문자 나눠서 담기
      String[] arr = selectedItems.split(",");
      List<Long> selectedCodes = new ArrayList<>();
      for (String s : arr) {
        selectedCodes.add(Long.parseLong(s));
      }

      Map<String, Object> params = new HashMap<>();
      params.put("memberIdx", memberIdx);
      params.put("selectedCodes", selectedCodes); // 장바구니
      cartItems = cartItemService.getCartItemsByCodes(params);
    } else {
      // 전체 조회
      Map<String, Object> params = new HashMap<>();
      params.put("memberIdx", memberIdx);
      cartItems = cartItemService.getCartItemsByMemberAndProduct(params);
    }

    model.addAttribute("cartItems", cartItems);

    ShippingInfo addressInfo = (ShippingInfo) session.getAttribute("memberAddress");
    if (addressInfo == null) {
      addressInfo = memberService.getShippingInfo(memberIdx);
    }
    if (addressInfo != null) {
      model.addAttribute("receiverName", addressInfo.getReceiverName());
      model.addAttribute("addName", addressInfo.getAddName());
      model.addAttribute("addTitle", addressInfo.getAddTitle());
      model.addAttribute("addDetail", addressInfo.getAddDetail());
      model.addAttribute("phone", addressInfo.getPhone());
      model.addAttribute("firstAdd", addressInfo.getFirstAdd());
    }
    List<ShippingInfo> list = shippingService.getShippingInfo(memberIdx);
    model.addAttribute("shippingAddresses", list);

    return "order/formtest";
  }

//  @PostMapping("submit")
  public String submitOrder1(HttpSession session, Model model) {
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


  @PostMapping("submit")
  public String submitOrder(
          @RequestParam(value = "selectedItems", required = false) List<Long> selectedItems,
          HttpSession session, Model model, RedirectAttributes redirectAttributes) {
    try {
      SessionInfo info = (SessionInfo) session.getAttribute("member");
      if (info == null) {
        return "redirect:/login";
      }

      Order processedOrder;
      if (selectedItems != null && !selectedItems.isEmpty()) {
        processedOrder = orderService.processOrder(info, selectedItems);
      } else {
        processedOrder = orderService.processOrder(info);
        // 일반 경로로 구매하기 ?
      }

      long lastOrderCode = orderService.getLatestOrderCode();
      log.info("orderService.getLatestOrderCode(){}", orderService.getLatestOrderCode());
      String formattedDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
      String orderCode = formattedDate + String.format("%09d", lastOrderCode);

      redirectAttributes.addFlashAttribute("order", processedOrder);
      redirectAttributes.addFlashAttribute("orderCode", orderCode);
      log.info("orderCode {}", orderCode);

      ShippingInfo addressInfo = (ShippingInfo) session.getAttribute("memberAddress");
      log.info("addressInfo {}", addressInfo);

      if(addressInfo == null) {
        addressInfo = memberService.getShippingInfo(info.getMemberIdx());
      }

      if (addressInfo != null) {
        redirectAttributes.addFlashAttribute("receiverName", addressInfo.getReceiverName());
        redirectAttributes.addFlashAttribute("phone", addressInfo.getPhone());
        redirectAttributes.addFlashAttribute("addrTitle", addressInfo.getAddTitle() + " " + addressInfo.getAddDetail());
      }
      return "redirect:/order/complete";
    } catch (Exception e) {
      log.error("Error processing order", e);
      redirectAttributes.addFlashAttribute("Message", "주문 처리 중 오류 발생..");
      return "redirect:/";
    }
  }

  @GetMapping("addr")
  public String addressForm(ShippingInfo info) {
    return "redirect:/order/formtest";
  }

  @PostMapping("insertAddress")
  @ResponseBody
  public Map<String, Object> addressSubmit(
          @ModelAttribute("infolist") ShippingInfo shippingInfo,
          HttpSession session) {
    Map<String, Object> map = new HashMap<>();

    try {
      SessionInfo info = (SessionInfo) session.getAttribute("member");
      long memberIdx = info.getMemberIdx();

      if (memberIdx == 0) {
        log.error("회원값 없음: {}", memberIdx);
        return map;
      }

      shippingInfo.setMemberIdx(memberIdx);

      // 배송지 등록
      orderService.insertShippingAddress(shippingInfo);

      List<ShippingInfo> list = shippingService.getShippingInfo(memberIdx);

      // 등록한 배송지를 세션에 저장
      session.setAttribute("memberAddress", shippingInfo);

      map.put("status", "success");
      map.put("memberAddressList", list);
    } catch (Exception e) {
      map.put("status", "error");
      map.put("message", e.getMessage());
    }
    return map;
  }


  @PostMapping("selectAddress")
  @ResponseBody
  public ResponseEntity<Map<String, Object>> selectShippingAddress(
          @ModelAttribute ShippingInfo shippingInfo,
          HttpSession session) {
    Map<String, Object> response = new HashMap<>();
    try {
      SessionInfo info = (SessionInfo) session.getAttribute("member");
      if (info == null) {
        response.put("status", "error");
        response.put("message", "로그인이 필요합니다.");
        return ResponseEntity.status(401).body(response);
      }

      shippingInfo.setMemberIdx(info.getMemberIdx());
      session.setAttribute("memberAddress", shippingInfo);

      response.put("status", "success");
      response.put("message", "배송지가 선택되었습니다.");
      return ResponseEntity.ok(response);
    } catch (Exception e) {
      response.put("status", "error");
      response.put("message", e.getMessage());
      return ResponseEntity.status(500).body(response);
    }
  }

  @GetMapping("complete")
  public String complete() {
    return "order/complete";
  }
}