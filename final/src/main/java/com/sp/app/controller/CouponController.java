package com.sp.app.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/coupon/*")
@Slf4j
public class CouponController {

    @PostMapping("use")
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




}
