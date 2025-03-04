package com.sp.app.controller;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.*;
import com.sp.app.service.*;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage/*")
@Slf4j
public class MyPageController {

    private final OrderService orderService;
    private final CouponService couponService;
    private final MemberService memberService;
    private final StorageService storageService;
    private final ImageUploadService imageUploadService;
    private final PointService pointService;
    private final MyPageService myPageService;
    private final PaginateUtil paginateUtil;
    private final ChangeService changeService;
    private final ViewService viewService;


    private String uploadPath;

	@PostConstruct
	public void init() {
		uploadPath = this.storageService.getRealPath("/uploads/mypage");
	}

    public String getUserProfile(HttpSession session, Model model) {
        try {
            SessionInfo member = (SessionInfo) session.getAttribute("member");
            if(member == null) {
                return "redirect:/member/login";
            }
            Member userProfile = memberService.findByUserEmail(member.getEmail());
            String profileImageFile = imageUploadService.getProfileImageFile(member.getMemberIdx());

            session.setAttribute("userProfile", userProfile);
            session.setAttribute("profileImageFile", profileImageFile);

            model.addAttribute("userProfile", userProfile);
            model.addAttribute("profileImageFile", profileImageFile);


        } catch (Exception e) {

        }
        return "mypage/sidebar";
    }

    @GetMapping("home")
    public String home(
            HttpSession session, Model model) {
        try {
            SessionInfo member = (SessionInfo) session.getAttribute("member");
            // 쿠폰 리스트 가져오기
            List<Coupon> couponList = orderService.getCouponList(member.getMemberIdx());
            MemberPoint userPoint = orderService.getLatestUserPoint(member.getMemberIdx());

            int couponCount = couponService.getCouponCount(member.getMemberIdx());
            Member userProfile = memberService.findByUserEmail(member.getEmail());
            List<Map<String, Long>> productParams = new ArrayList<>();
            Map<String, Long> paramMap = new HashMap<>();
            paramMap.put("memberIdx", member.getMemberIdx());
            productParams.add(paramMap);
            int balance = pointService.getPointEnabled(member.getMemberIdx());
            List<MyPage> ordersHistory = myPageService.getOrdersHistory(member.getMemberIdx());
            for (MyPage item : ordersHistory) {
                model.addAttribute("orderDate", item.getOrderDate());
            }
            List<ViewProduct> viewProductHistory = viewService.getViewProductHistory(member.getMemberIdx());
            model.addAttribute("balance", balance); // 현재 사용할 수 있는 포인트 금액
            model.addAttribute("couponList", couponList); // 쿠폰 리스트
            model.addAttribute("couponCount", couponCount); // 쿠폰 개수
            model.addAttribute("userPoint", userPoint);
            model.addAttribute("userProfile", userProfile);
            model.addAttribute("ordersHistory", ordersHistory);
            model.addAttribute("viewProductHistory", viewProductHistory);

            String profileImageFile = imageUploadService.getProfileImageFile(member.getMemberIdx());

            session.setAttribute("userProfile", userProfile);
            session.setAttribute("profileImageFile", profileImageFile);

            model.addAttribute("userProfile", userProfile);
            model.addAttribute("profileImageFile", profileImageFile);

        } catch (Exception e) {
            log.error("마이페이지  예외 발생", e);
        }
        return "mypage/home1";
    }

    @PostMapping("image")
    @ResponseBody
    public Map<String, Object> image(
            HttpSession session,
            @RequestParam("profileFile") MultipartFile file,
            UserImage dto
    ) {
        Map<String, Object> map = new HashMap<>();
        try {
            SessionInfo info = (SessionInfo) session.getAttribute("member");
            if (info == null) {
                throw new Exception("로그인 정보가 없습니다.");
            }

            dto.setMemberIdx(info.getMemberIdx());

            String savedFilename = imageUploadService.uploadImage(file, dto);

            map.put("success", true);
            map.put("image", savedFilename);
        } catch (Exception e) {
            log.error("프로필 이미지 업로드 에러 발생", e);
            map.put("error", e.getMessage());
        }
        return map;
    }

    @GetMapping("detail")
    public String detail(
            @RequestParam(value = "page", defaultValue = "1") int current_page,
            @RequestParam(value = "keyword", defaultValue = "", required = false) String keyword,
            HttpSession session, Model model, HttpServletRequest request) {
        try {
			int size = 5;
			int dataCount = 0;

            SessionInfo member = (SessionInfo) session.getAttribute("member");

            dataCount = myPageService.dataCount(member.getMemberIdx()); // 구매한 내역 개수

            int total_page = paginateUtil.pageCount(dataCount, size); // 전체 페이지

            current_page = Math.min(current_page, total_page); // 현재 페이지와 전체 페이지 비교

            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;

            String cp = request.getContextPath();
            String listUrl = cp + "/review/detail";

            if(keyword != null && !keyword.isEmpty()){
                listUrl += "?keyword=" + keyword;
            }

            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            Map<String, Object> map = new HashMap<>();
            map.put("offset", offset);
            map.put("size", size);
            map.put("dataCount", dataCount);
            map.put("memberIdx", member.getMemberIdx());


            List<MyPage> ordersHistory = myPageService.getOrdersHistory1(map);
            model.addAttribute("ordersHistory", ordersHistory);
            model.addAttribute("paging", paging);
            model.addAttribute("size", size);
            model.addAttribute("offset", offset);
            model.addAttribute("total_page", total_page);
            model.addAttribute("page", current_page);

            return "mypage/detail";
        } catch (Exception e) {
            log.error("detail", e);
            throw new RuntimeException(e);
        }
    }

    @GetMapping("orderDetail")
    public String orderDetail(
            @RequestParam("orderCode") String orderCode,
            HttpSession session, Model model, Payment payment) {
        try {
            SessionInfo member = (SessionInfo) session.getAttribute("member");
            if (member == null) {
                return "redirect:/member/login";
            }

            Map<String, Object> map = new HashMap<>();
            map.put("memberIdx", member.getMemberIdx());
            map.put("orderCode", orderCode);
            payment.setOrderCode(orderCode);

            Payment paymentHistory = myPageService.getPaymentHistory(payment);
            MyPage orderDetail = myPageService.getOrderHistoryDetail(map);
            model.addAttribute("orderDetail", orderDetail);
            model.addAttribute("paymentHistory", paymentHistory);

        } catch (Exception e) {
            log.error("주문상세 조회 중 오류 발생", e);
            return "mypage/detail";
        }
        return "mypage/orderDetail"; // JSP 파일명
    }


    @GetMapping("refunds")
    public String changeRequest(@ModelAttribute Change change,
                                @RequestParam long itemCode,
                                HttpSession session, Model model) {
        try {
            SessionInfo member = (SessionInfo) session.getAttribute("member");
            changeService.insertChangeRequest(change);


        } catch(Exception e) {
            log.error("changeRequest", e);
        }
        return "redirect:/mypage/detail";
    }

    @GetMapping("refunds/detail")
    public String changeDetail(
            @RequestParam(value = "page", defaultValue = "1") int current_page,
            @RequestParam(value = "keyword", defaultValue = "", required = false) String keyword,
            HttpServletRequest request, HttpSession session, Model model) {

        try {
            int size = 5;
            int dataCount = 0;
            SessionInfo member = (SessionInfo) session.getAttribute("member");
            if(member == null) {
                log.error("member가 null..");
            }
            dataCount = changeService.dataCount(member.getMemberIdx());

            int total_page = paginateUtil.pageCount(dataCount, size);

            current_page = Math.min(current_page, total_page);

            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;

            String cp = request.getContextPath();
            String listUrl = cp + "/mypage/refunds/detail";

            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            Map<String, Object> map = new HashMap<>();
            map.put("offset", offset);
            map.put("size", size);
            map.put("dataCount", dataCount);
            map.put("memberIdx", member.getMemberIdx());

            List<Change> requestList = changeService.getRequestList(map);
            log.error("requestList{}", requestList);
            model.addAttribute("paging", paging);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("offset", offset);
            model.addAttribute("total_page", total_page);
            model.addAttribute("size", size);
            model.addAttribute("page", current_page);
            model.addAttribute("requestList", requestList);
        } catch(Exception e) {
            log.error("changeDetail error", e);
        }
        return "mypage/refunds";
    }



}
