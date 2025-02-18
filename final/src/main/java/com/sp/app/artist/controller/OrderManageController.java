package com.sp.app.artist.controller;

import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;
import com.sp.app.artist.service.OrderStatusManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.model.ShippingInfo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.jackson.JsonMixinModule;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;


@Controller
@RequestMapping("/artist/orderManage/*")
@Slf4j
@RequiredArgsConstructor
public class OrderManageController {
        private final OrderStatusManageService service;
        private final PaginateUtil paginateUtil;
    private final JsonMixinModule jsonMixinModule;
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
            Model model, HttpServletRequest req, HttpSession session
            )throws Exception{
        try {
            int size = 10;
            int total_page;
            int dataCount;

            kwd = URLDecoder.decode(kwd,"UTF-8");
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            Map<String,Object>map = new HashMap<>();
            map.put("tebNum",tebNum);
            map.put("schType",schType);
            map.put("kwd",kwd);
            map.put("memberIdx",info.getMemberIdx());

            dataCount = service.orderCount(map);
            total_page=paginateUtil.pageCount(dataCount,size);

            current_page = Math.min(current_page,total_page);

            int offset = (current_page -1) * size;
            if (offset<0)offset=0;
            map.put("offset",offset);
            map.put("size",size);

            List<OrderManage> list = service.listOrder(map);


            String cp = req.getContextPath();
            String listUrl = cp+ "/artist/orderManage/"+tebNum;

            String query = "page="+current_page;
            String qs = "";
            if (kwd.length()!=0){
                qs = "schType="+schType+"&kwd="+ URLEncoder.encode(kwd,"UTF-8");
                listUrl += "?" +qs;
                query +="&"+qs;
            }
            String paging = paginateUtil.pagingUrl(current_page,total_page,listUrl);

            String title = "주문 현황";
            if (tebNum ==110){
                title = "배송 현황";
            } else if (tebNum ==120) {
                title = "주문 전체 리스트";
            }
            model.addAttribute("title", title);
            model.addAttribute("tebNum", tebNum);

            model.addAttribute("list", list);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("query", query);

            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);

            model.addAttribute("page", current_page);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);


        }catch (Exception e){
            log.info("orderManagement:",e);
        }


        return "artist/orderManage/orderManagement";
    }

    @GetMapping("/{tebNum}/{item_code}")
    public String handleOrderDetails(
            @PathVariable("tebNum")int tebNum,
            @PathVariable("item_code")String item_code,
            @RequestParam(name = "page")String page,
            @RequestParam(name = "schType",defaultValue = "item_code")String schType,
            @RequestParam(name = "kwd",defaultValue = "")String kwd,
            Model model , HttpSession session
    )throws Exception {
        String query = "page=" + page;
        try {
            kwd = URLDecoder.decode(kwd, "utf-8");

            if (!kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
            }


            //주문정보
            OrderManage order = service.findByOrderId(item_code);


            //상품정보
            OrderProduct product = service.OrderDetails(item_code);


            //배송지
//            ShippingInfo shippingInfo = service.

            model.addAttribute("tebNum", tebNum);
            model.addAttribute("order", order);
            model.addAttribute("Product", product);
//            model.addAttribute("shippingInfo",shippingInfo);
//            model.addAttribute("delivery",delivery);
            model.addAttribute("query", query);
            model.addAttribute("page", page);

            return "artist/orderManage/orderDetail";


        } catch (NullPointerException e) {
            log.info("NullPointException :",e);
        } catch (Exception e) {
            log.info("handelOrderDetails : ", e);
        }

        return "redirect:/artist/orderManage/" + tebNum +"?" + query;

    }





}
