package com.sp.app.controller;

import com.sp.app.model.*;
import com.sp.app.model.cart.CartItem;
import com.sp.app.service.*;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    private final PointService pointService;
    private final OptionService optionService;

    @RequestMapping(value = "form", method = {RequestMethod.GET, RequestMethod.POST})
    public String orderForm(
        @RequestParam(name = "cartItemCode", required = false) List<Long> cartItemCodes,
        @RequestParam(name = "productCode", required = false) List<Long> productCodes,
        @RequestParam(name = "quantity", required = false) List<Integer> quantities,
        @RequestParam(name = "discount", required = false, defaultValue="0") int discountAmount,
        @RequestParam(name = "mode", required = false, defaultValue = "cart") String mode,
        HttpSession session, Model model) throws Exception {

        // 회원 정보 확인
        SessionInfo info = (SessionInfo) session.getAttribute("member");
        if (info == null) {
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
            model.addAttribute("postCode", addressInfo.getPostCode());
        }

        List<ShippingInfo> shippingInfolist = shippingService.getShippingInfo(memberIdx);
        List<Coupon> couponList = orderService.getCouponList(memberIdx);
        model.addAttribute("shippingAddresses", shippingInfolist);
        model.addAttribute("couponList", couponList);

        // mode에 따라 구매 방식 분기 ("direct"면 바로구매, 아니면 장바구니 구매)
        List<CartItem> cartItems = new ArrayList<>();
        List<OrderItem> orderItems = new ArrayList<>();

        if ("direct".equals(mode)) {
            if (productCodes == null || quantities == null ||
                productCodes.isEmpty() || quantities.isEmpty()) {
                throw new Exception("주문 정보가 부족합니다. (직접 구매)");
            }
            for (int i = 0; i < productCodes.size(); i++) {
                OrderItem item = new OrderItem();
                item.setProductCode(productCodes.get(i));
                item.setQuantity(quantities.get(i));
                OrderItem productInfo = orderService.getProductCode(productCodes.get(i));
                if (productInfo == null) {
                    throw new Exception("상품 정보가 존재하지 않습니다. productCode=" + productCodes.get(i));
                }

                int discountedPrice = productInfo.getPrice() - discountAmount;
                if (discountedPrice < 0) discountedPrice = 0;

//                item.setPriceForeach(productInfo.getPrice());
                item.setPriceForeach(discountedPrice);
                item.setPrice(quantities.get(i) * item.getPriceForeach());
                orderItems.add(item);
            }
        } else {
            // 장바구니 구매
            if (cartItemCodes != null && !cartItemCodes.isEmpty()) {
                Map<String, Object> params = new HashMap<>();
                params.put("memberIdx", member.getMemberIdx());
                params.put("selectedCodes", cartItemCodes);
                cartItems = cartItemService.getCartItemsByCodes(params);
            }
        }

        // 총합 계산: 장바구니 구매는 cartItems, 바로 구매는 orderItems를 기준으로 계산
        int totalMoney = 0;
        int shippingFee = 0;
        if (!cartItems.isEmpty()) {
            for (CartItem cart : cartItems) {
                int itemTotal = cart.getQuantity() * cart.getPrice();
                totalMoney += itemTotal;
                if (itemTotal < 20000) {
                    shippingFee += 3000;
                }
            }
        } else if (!orderItems.isEmpty()) {
            for (OrderItem oi : orderItems) {
                int itemTotal = oi.getQuantity() * oi.getPriceForeach();
                totalMoney += itemTotal;
                if (itemTotal < 20000) {
                    shippingFee += 3000;
                }
            }
        }
        int overallNetPay = totalMoney + shippingFee;

        // 회원 포인트
        MemberPoint memberPoint = orderService.getLatestUserPoint(memberIdx);
        int balance = pointService.getPointEnabled(memberIdx);
        model.addAttribute("balance", balance);
        model.addAttribute("memberPoint", memberPoint);

        // 주문번호 생성
        String productOrderCode = orderService.getLatestOrderCode();
        Order order = new Order();
        order.setOrderCode(productOrderCode);
        order.setTotalPrice(overallNetPay);

        Map<Long, List<Option>> productOptionsMap = new HashMap<>();
        for (int i = 0; i < productCodes.size(); i++) {
            long code = productCodes.get(i);
            List<Option> optionList = optionService.getOptionList(code);
            productOptionsMap.put(code, optionList);
        }
        model.addAttribute("optionList", productOptionsMap);


        for (CartItem cartItem : cartItems) {
            model.addAttribute("name", cartItem.getItem());
        }


        model.addAttribute("cartItems", cartItems);
        model.addAttribute("orderItems", orderItems);
        model.addAttribute("productTotal", totalMoney);
        model.addAttribute("shippingFee", shippingFee);
        model.addAttribute("overallNetPay", overallNetPay);
        model.addAttribute("order", order);
        model.addAttribute("mode", mode);

        return "order/formtest2";
    }

    @PostMapping("submit")
    public String submitOrder(
        @RequestParam(value = "selectedItems", required = false) List<Long> selectedItems,
        @RequestParam(value = "require", required = false) String require,
        Order order, ShippingInfo shippingInfo,
        HttpSession session, @ModelAttribute("payment") Payment payment,
        RedirectAttributes redirectAttributes) {
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                return "redirect:/member/login";
            }
            shippingInfo.setRequire(require);

            order.setShippingInfo(shippingInfo);
            if (selectedItems != null && !selectedItems.isEmpty()) {
                order = orderService.processOrder(info, selectedItems, order, payment);
            } else {
                order = orderService.processOrder(info, order, payment);
            }

            redirectAttributes.addFlashAttribute("order", order);

            ShippingInfo addressInfo = (ShippingInfo) session.getAttribute("memberAddress");
            if (addressInfo == null) {
                addressInfo = memberService.getShippingInfo(info.getMemberIdx());
            }
            if (addressInfo != null) {
                redirectAttributes.addFlashAttribute("receiverName", addressInfo.getReceiverName());
                redirectAttributes.addFlashAttribute("phone", addressInfo.getPhone());
                redirectAttributes.addFlashAttribute("addrTitle",
                    addressInfo.getAddTitle() + " " + addressInfo.getAddDetail());
            }
            return "redirect:/order/complete";
        } catch (Exception e) {
            log.error("Error processing order", e);
            redirectAttributes.addFlashAttribute("Message", "주문 처리 중 오류 발생.");
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
                map.put("status", "error");
                map.put("message", "회원 정보가 없습니다.");
                return map;
            }
            shippingInfo.setMemberIdx(memberIdx);
            orderService.insertShippingAddress(shippingInfo);
            List<ShippingInfo> list = shippingService.getShippingInfo(memberIdx);
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