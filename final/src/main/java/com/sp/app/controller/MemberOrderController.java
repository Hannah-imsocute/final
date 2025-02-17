package com.sp.app.controller;

import com.sp.app.model.*;
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
public class MemberOrderController {

  private final MemberService memberService;
  private final OrderService orderService;
  private final CartItemService cartItemService;
  private final ShippingService shippingService;


  @RequestMapping(value = "form", method = {RequestMethod.GET, RequestMethod.POST})
  public String orderForm(
          @RequestParam(name = "cartItemCode", required=false) List<Long> cartItemCodes,
          @RequestParam(name = "productCode", required = false) List<Long> productCodes,
          @RequestParam(name = "quantity", required = false) List<Long> quantities,
          HttpSession session, Model model) throws Exception {

    // 회원 정보 확인
    SessionInfo info = (SessionInfo)session.getAttribute("member");
    if(info == null) {
      return "redirect:/member/login";
    }
    long memberIdx = info.getMemberIdx();
    Member member = memberService.findByUserEmail(info.getEmail());

    // 배송지 정보 가져오기
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
    List<ShippingInfo> shippingInfolist = shippingService.getShippingInfo(memberIdx);
    List<Order> couponList = orderService.getCouponList(memberIdx);
    model.addAttribute("shippingAddresses", shippingInfolist);
    model.addAttribute("couponList", couponList);


    List<CartItem> items = new ArrayList<>();
    if (cartItemCodes != null && !cartItemCodes.isEmpty()) {
      // 장바구니 구매 -> 선택된거만
      Map<String, Object> params = new HashMap<>();
      params.put("memberIdx", member.getMemberIdx());
      params.put("selectedCodes", cartItemCodes);
      items = cartItemService.getCartItemsByCodes(params);
    } else if (productCodes != null && quantities != null
            && !productCodes.isEmpty() && !quantities.isEmpty()) {
      // 바로 구매하기
      for (int i = 0; i < productCodes.size(); i++) {
        CartItem item = new CartItem();
        item.setProductCode(productCodes.get(i));
        item.setQuantity(quantities.get(i).intValue());
        item.setPrice(10000);
        // 옵션
        items.add(item);
      }
    }
    model.addAttribute("cartItems", items);

    int totalMoney = 0;   // 상품 금액
    int shippingFee = 0;  // 배송비
    MemberPoint memberPoint = orderService.getLatestUserPoint(memberIdx);
    model.addAttribute("memberPoint", memberPoint);

    for (CartItem cart : items) {
      int itemTotal = cart.getQuantity() * cart.getPrice();
      totalMoney += itemTotal;
      //  상품 금액이 20,000원 미만이면 배송비 3,000원
      if (itemTotal < 20000) {
        shippingFee += 3000;
      }
    }
    int overallNetPay = totalMoney + shippingFee;

    // 주문번호 생성
    String productOrderCode = orderService.getLatestOrderCode();

    Order order = new Order();
    order.setOrderCode(productOrderCode);
    order.setTotalPrice(overallNetPay);

    model.addAttribute("productTotal", totalMoney);
    model.addAttribute("shippingFee", shippingFee);
    model.addAttribute("overallNetPay", overallNetPay);
    model.addAttribute("order", order);

    return "order/formtest";
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
      }

      redirectAttributes.addFlashAttribute("order", processedOrder);

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
  public String complete(@ModelAttribute("order") Order order, Model model) {
    return "order/complete";
  }
}