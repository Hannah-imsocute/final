package com.sp.app.artist.controller;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/artist/orderManage/*")
@Slf4j
@RequiredArgsConstructor
public class OrderManageController {

    //tebNum: 주문통합검색-100   미결제 확인 -110   발주확인/발송관리 -120   배송현황관리 -130  구매확정 내역-140  취소관리 -150
    //oracle 테이블에서 주문상태 : 0:입금대기,1:결제완료,2:발송처리,3:배송시작,4:배송중,5:배송완료,6:관리자 전체 판매취소,
    //7:관리자부분판매취소,8:주문자전체주문취소 9:주문자부분주문취소


    //주문 통합검색 리스트
    @GetMapping("/{tebNum}")
    public String orderManagement(
            @PathVariable("tebNum")int tebNum,
            @RequestParam(name = "page",defaultValue = "1")int current_page,
            @RequestParam(name = "schType",defaultValue = "orderNum")String schType,
            @RequestParam(name = "kwd",defaultValue = "")String kwd,
            Model model, HttpServletRequest req
            )throws Exception{
        try {
            int size = 10;
            int total_page;





        }catch (Exception e){
            log.info("orderManagement:",e);
        }













        return "artist/orderManage/orderManagement";
    }

}
