package com.sp.app.controller;

import com.sp.app.model.SessionInfo;
import com.sp.app.model.ShippingInfo;
import com.sp.app.model.cart.CartItem;
import com.sp.app.service.CartItemService;
import com.sp.app.service.MemberService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order/*")
@RequiredArgsConstructor
public class MemberOrderController {

  private final CartItemService cartItemService;
  private final MemberService memberService;

  @GetMapping("form")
  public String orderForm(HttpSession session, Model model) throws Exception{
    Long memberIdx = getMemberIdx(session);

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

  @PostMapping
  public String orderSubmit(){

    return null;
  }

  private static Long getMemberIdx(HttpSession session) {
    SessionInfo member = (SessionInfo) session.getAttribute("member");
    return member.getMemberIdx();
  }


}
