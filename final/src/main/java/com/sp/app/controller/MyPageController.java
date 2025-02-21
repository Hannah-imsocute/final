package com.sp.app.controller;

import com.sp.app.model.*;
import com.sp.app.service.CartItemService;
import com.sp.app.service.CouponService;
import com.sp.app.service.OrderService;
import com.sp.app.service.ShippingService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage/*")
@Slf4j
public class MyPageController {

	private final CartItemService cartItemService;
	private final OrderService orderService;
	private final CouponService couponService;
	private final ShippingService shippingService;


	@GetMapping("home")
	public String home(
			HttpSession session, Model model
	) {
		try {
			SessionInfo member = (SessionInfo) session.getAttribute("member");
			// 쿠폰 리스트 가져오기
			List<Coupon> couponList = orderService.getCouponList(member.getMemberIdx());
			MemberPoint userPoint = orderService.getLatestUserPoint(member.getMemberIdx());
			int couponCount = couponService.getCouponCount(member.getMemberIdx());

			List<Map<String, Long>> productParams = new ArrayList<>();
			Map<String, Long> paramMap = new HashMap<>();
			paramMap.put("memberIdx", member.getMemberIdx());
			productParams.add(paramMap);

			List<Order> orderList = orderService.listOrderProduct(productParams);
			for (Order order : orderList) {
//				order.get
			}

			model.addAttribute("couponList", couponList);
			model.addAttribute("couponCount", couponCount);
			model.addAttribute("userPoint", userPoint);
			model.addAttribute("orderList", orderList);
		} catch(Exception e) {
			log.error("마이페이지  예외 발생", e);
		}
		return "mypage/home";
	}

}
