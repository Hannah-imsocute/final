package com.sp.app.controller;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Coupon;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.CouponService;
import com.sp.app.service.OrderService;
import jakarta.servlet.http.HttpServletRequest;
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
@RequestMapping("/coupon/*")
@RequiredArgsConstructor
@Slf4j
public class CouponController {

    private final PaginateUtil paginateUtil;
    private final CouponService couponService;
    private final OrderService orderService;

    @PostMapping("use")
    @ResponseBody
    // AJAX - JSON
    public Map<String, Object> couponSubmit(
            @RequestParam(name = "couponCode") String couponCode
    ) {
        Map<String, Object> response = new HashMap<>();
        try {
            response.put("status", "success");
        } catch(Exception e) {
            response.put("status", "error");
            response.put("message", "<p> 쿠폰 적용이 실패했습니다. </p>");
            log.info("couponSubmit", e);
        }
        return response;
    }

    @GetMapping("detail")
    public String historyCoupon(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            HttpServletRequest request, Model model, HttpSession session){
        try {
            SessionInfo member = (SessionInfo) session.getAttribute("member");
            int size = 5;
            int dataCount = 0;

            dataCount = couponService.getCouponCount(member.getMemberIdx());

            int total_page = paginateUtil.pageCount(dataCount, size);

            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;

            String cp = request.getContextPath();
            String listUrl = cp + "/coupon/detail";
            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            List<Coupon> couponList = orderService.getCouponList(member.getMemberIdx());

            model.addAttribute("paging", paging);
            model.addAttribute("page", current_page);
            model.addAttribute("size", size);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("total_page", total_page);
            model.addAttribute("couponList", couponList);
        } catch (Exception e){
            log.error("마이페이지 쿠폰.. 오류",e);
        }

        return "mypage/couponDetail";

    }






}
