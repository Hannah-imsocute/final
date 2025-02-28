package com.sp.app.artist.controller;

import com.sp.app.artist.model.OrderDetailManage;
import com.sp.app.artist.model.OrderManage;
import com.sp.app.artist.model.OrderProduct;
import com.sp.app.artist.service.OrderStatusManageService;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.artist.model.ShippingInfo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.jackson.JsonMixinModule;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
            @RequestParam(name = "schType",defaultValue = "item_code")String schType,
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

            String title = "통합 리스트";
            if (tebNum ==110){
                title = "발송처리하기(주문확인)";
            } else if (tebNum ==120) {
                title = "배송 현황 내역";
            } else if (tebNum ==130) {
                title = "구매확정 내역";
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
            @RequestParam(name = "deliveryName", defaultValue = "") String deliveryName,

            Model model , HttpSession session
    )throws Exception {
        String query = "page=" + page;
        try {
            kwd = URLDecoder.decode(kwd, "utf-8");

            if (!kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
            }
            // deliveryName을 숫자로 변환
            int deliveryId = 0;
            if (!deliveryName.isBlank()) {
                try {
                    deliveryId = Integer.parseInt(deliveryName); // String을 int로 변환
                } catch (NumberFormatException e) {
                    // 변환 실패 시 적절한 처리 (예: 예외 처리 또는 기본값 설정)
                    log.error("Invalid deliveryName: " + deliveryName);
                }
            }
// 변경

            //주문정보
            OrderManage order = service.findByOrderId(item_code);


            //상품정보
            OrderProduct product = service.OrderDetails(item_code);


            //배송회사
            List<Map<String,Object>> listDeliveryCompany = service.listDeliveryCompany();


            ShippingInfo shippingInfo = service.findByDeliveryId(item_code);

            model.addAttribute("tebNum", tebNum);
            model.addAttribute("order", order);
            model.addAttribute("Product", product);
            model.addAttribute("shippingInfo",shippingInfo);
            model.addAttribute("listDeliveryCompany",listDeliveryCompany);
            model.addAttribute("query", query);
            model.addAttribute("page", page);
            model.addAttribute("deliveryId", deliveryId);

            return "artist/orderManage/orderDetail";


        } catch (NullPointerException e) {
            log.info("NullPointException :",e);
        } catch (Exception e) {
            log.info("handelOrderDetails : ", e);
        }

        return "redirect:/artist/orderManage/" + tebNum +"?" + query;

    }

    @PostMapping("invoiceNumber")
    @ResponseBody
    public Map<String,?> invoiceNumber(@RequestParam Map<String,Object> paramMap ){
        //배송  상태 변경
        Map<String,Object> model = new HashMap<String,Object>();

        String state = "true";
        try {
            String deliveryName = (String) paramMap.get("deliveryName");
            int deliveryId = 0;
            if (deliveryName != null && !deliveryName.isBlank()) {
                try {
                    deliveryId = Integer.parseInt(deliveryName);
                } catch (NumberFormatException e) {
                    log.error("Invalid deliveryName: " + deliveryName);
                }
            }





             String a =  (String) paramMap.get("orderNum");
             int num =  Integer.parseInt(a);

            System.out.println("asdfsadgsagasgsagsagasgsagasgasgsagasgdsaga"+paramMap.get("invoiceNumber"));
            paramMap.put("deliveryName", deliveryId);
            paramMap.put("num", num);
            service.updateOrder("invoiceNumber",paramMap);
        }catch (Exception e){
            state = "false";


        }
        model.put("state",state);



        return model;
    }


    @PostMapping("delivery")
    @ResponseBody
    public Map<String, ?> delivery(@RequestParam Map<String, Object> paramMap) {
        // 배송 상태 변경
        Map<String, Object> model = new HashMap<String, Object>();

        String state = "true";


        try {


            String a =  (String) paramMap.get("item_code");
            int num =  Integer.parseInt(a);
            paramMap.put("num", num);

            service.updateOrder("delivery", paramMap);
        } catch (Exception e) {
            state = "false";
        }

        model.put("state", state);
        return model;
    }
    @PostMapping("updateChangeState")
    @ResponseBody
    public Map<String,?> updateChangeState(
            @RequestParam Map<String,Object>paramMap,HttpSession session
    ){
        Map<String,Object> model = new HashMap<String,Object>();
        String state = "true";
        try {

            SessionInfo info = (SessionInfo) session.getAttribute("member");
            int orderState =Integer.parseInt((String)paramMap.get("orderState"));
            paramMap.put("memberIdx",info.getMemberIdx());
            service.updateOrderChangeState(paramMap);
            model.put("orderState",orderState);



        }catch (Exception e){
            state = "false";
        }
            model.put("state",state);
    return  model;


    }





    @GetMapping("detailManage/{tebNum}")
    public  String handleDetailManageList(
            @PathVariable("tebNum") int tebNum,
            @RequestParam(name="page",defaultValue = "1")int current_page,
            @RequestParam(name = "schType",defaultValue = "item_code")String schType,
            @RequestParam(name = "kwd",defaultValue = "")String kwd,
            Model model,HttpServletRequest req,HttpSession session
    )throws Exception{

        //배송전 환불 취소 같은리스트

        //tebNUm: 100-배송후교환, 110-구매확정,
        //         200 -배송전환불, 210 -배송후반품, 220-판매취소, 230-취소전체리스트

        try {

            int size = 10;
            int total_page;
            int dataCount;

            kwd = URLDecoder.decode(kwd,"UTF-8");
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            Map<String,Object> map = new HashMap<>();
            map.put("tebNum",tebNum);
            map.put("schType",schType);
            map.put("kwd",kwd);
            map.put("memberIdx",info.getMemberIdx());

            dataCount = service.detailCount(map);
            total_page = paginateUtil.pageCount(dataCount,size);

            current_page = Math.min(current_page,total_page);


            int offset = (current_page -1) * size;
            if(offset <0)offset =0;

            map.put("offset",offset);
            map.put("size",size);

            List<OrderDetailManage> list = service.listDetails(map);

            String cp = req.getContextPath();
            String listUrl = cp + "/artist/orderManage/detailManage/"+tebNum;

            String query = "page=" +current_page;
            String qs ="";
            if (kwd.length() !=0){
                qs ="schType="+schType+"&kwd="+URLEncoder.encode(kwd,"UTF-8");
                listUrl += "?" +qs;
                query += "&" +qs;
            }
            String paging = paginateUtil.pagingUrl(current_page,total_page,listUrl);

            String title = "구매확정 현황";
            if(tebNum == 100) {
                title = "배송후 교환 현황";
            } else if(tebNum == 200) {
                title = "배송전 환불 현황";
            } else if(tebNum == 210) {
                title = "배송후 반품 현황";
            } else if(tebNum == 220) {
                title = "판매취소 현황";
            } else if(tebNum == 230) {
                title = "취소 전체 리스트";
            }

            model.addAttribute("title",title);
            model.addAttribute("tebNum",tebNum);

            model.addAttribute("list",list);
            model.addAttribute("dataCount",dataCount);


            model.addAttribute("schType", schType);
            model.addAttribute("kwd", kwd);

            model.addAttribute("page", current_page);
            model.addAttribute("size", size);
            model.addAttribute("total_page", total_page);
            model.addAttribute("paging", paging);
            model.addAttribute("query", query);


        }catch (Exception e){
            log.info("handleDetailManageList : ", e);

        }



        return "artist/orderManage/detailManage";


    }


    @GetMapping("detailManage/{tebNum}/{item_code}")
    public String handleDetailView(
            @PathVariable("tebNum") int tebNum,
            @PathVariable("item_code")String item_code,
            @RequestParam(name = "page") String page,
            @RequestParam(name = "schType", defaultValue = "item_code") String schType,
            @RequestParam(name = "kwd",defaultValue = "") String kwd,
            Model model,
            HttpServletRequest req,HttpSession session


    ) throws Exception{
        String query = "page=" +page;
        try {
            kwd = URLDecoder.decode(kwd,"utf-8");
            if (! kwd.isBlank()) {
                query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "UTF-8");
            }

            // 주문 상세 정보
            OrderDetailManage dto = Objects.requireNonNull(service.findByDetailId(item_code));

            // 주문 정보의 구매 리스트
            List<OrderDetailManage> listBuy = service.listOrderDetails(dto.getItem_code());

            // 결제 정보
            Map<String, Object> payDetail = service.findByPayDetail(item_code);

            model.addAttribute("tebNum", tebNum);
            model.addAttribute("dto", dto);
            model.addAttribute("listBuy", listBuy);
            model.addAttribute("payDetail", payDetail);

            model.addAttribute("query", query);
            model.addAttribute("page", page);



            return "artist/orderManage/detailView";


        }catch (Exception e){
            log.info("handleDetailView:",e);
        }






        return "redirect:/artist/orderManage/detailManage/"+tebNum+"?"+query;



    }


    @GetMapping("listDetailState")
    @ResponseBody
    public Map<String,Object> listDetailState(@RequestParam(name = "orderState")int orderState,
                                              @RequestParam(name = "item_code")String item_code
                                              ){
        Map <String,Object>model = new HashMap<>();
        try {
            List<Map<String,Object>> list = null;
            list = service.listDetailStateInfo(item_code);
            model.put("list",list);
            model.put("orderState",orderState);

        }catch (Exception e){
            log.info("listDetailState : ",e);
        }
        return model;

    }






}
