package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	@GetMapping("/admin")
	public String adminHome(Model model) {
	    model.addAttribute("contentPage", "admin/statsList/statsList.jsp");
	    model.addAttribute("pageTitle", "통계 및 보고");
	    return "admin/home";
	}


    // 권한 관리 페이지
    @GetMapping("/admin/authList")
    public String authList(Model model) {
        model.addAttribute("contentPage", "admin/authList/authList.jsp");  // 상대 경로
        model.addAttribute("pageTitle", "권한관리");
        return "admin/home"; // 공통 레이아웃인 home.jsp를 반환
    }

    // 입점 신청 관리 페이지
    @GetMapping("/admin/applyList")
    public String applyList(Model model) {
        model.addAttribute("contentPage", "admin/applyList/applyList.jsp");
        model.addAttribute("pageTitle", "입점신청관리");
        return "admin/home";
    }

    // 멤버십 관리 페이지
    @GetMapping("/admin/membershipList")
    public String membershipList(Model model) {
        model.addAttribute("contentPage", "admin/membershipList/membershipList.jsp");
        model.addAttribute("pageTitle", "멤버십관리");
        return "admin/home";
    }

    // 결제 및 정산 관리 페이지
    @GetMapping("/admin/paymentList")
    public String paymentList(Model model) {
        model.addAttribute("contentPage", "admin/paymentList/paymentList.jsp");
        model.addAttribute("pageTitle", "결제 및 정산관리");
        return "admin/home";
    }

    // 상품 관리 페이지
    @GetMapping("/admin/productList")
    public String productList(Model model) {
        model.addAttribute("contentPage", "admin/productList/productList.jsp");
        model.addAttribute("pageTitle", "상품관리");
        return "admin/home";
    }

    // 이벤트 관리 페이지
    @GetMapping("/admin/eventList")
    public String eventList(Model model) {
        model.addAttribute("contentPage", "admin/eventList/eventList.jsp");
        model.addAttribute("pageTitle", "이벤트관리");
        return "admin/home";
    }

    // 공지사항 관리 페이지
    @GetMapping("/admin/noticeList")
    public String noticeList(Model model) {
        model.addAttribute("contentPage", "admin/noticeList/noticeList.jsp");
        model.addAttribute("pageTitle", "공지사항관리");
        return "admin/home";
    }

    // 문의사항 관리 페이지
    @GetMapping("/admin/inquiryList")
    public String inquiryList(Model model) {
        model.addAttribute("contentPage", "admin/inquiryList/inquiryList.jsp");
        model.addAttribute("pageTitle", "문의사항관리");
        return "admin/home";
    }

    // 신고 관리 페이지
    @GetMapping("/admin/reportList")
    public String reportList(Model model) {
        model.addAttribute("contentPage", "admin/reportList/reportList.jsp");
        model.addAttribute("pageTitle", "신고관리");
        return "admin/home";
    }

    // 통계 및 보고 페이지
    @GetMapping("/admin/statsList")
    public String statsList(Model model) {
        model.addAttribute("contentPage", "admin/statsList/statsList.jsp");
        model.addAttribute("pageTitle", "통계 및 보고");
        return "admin/home";
    }
}
