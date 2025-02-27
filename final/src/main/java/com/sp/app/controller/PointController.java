package com.sp.app.controller;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.MemberPoint;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.PointService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/point/*")
@RequiredArgsConstructor
@Slf4j
public class PointController {

    private final PaginateUtil paginateUtil;
    private final PointService pointService;

    @GetMapping("detail")
    public String historyPoint(
            @RequestParam(name = "page", defaultValue = "1") int current_page,
            HttpServletRequest request, Model model, HttpSession session){
        try {
            SessionInfo member = (SessionInfo) session.getAttribute("member");
            int size = 5;
            int dataCount = 0;

            dataCount = pointService.dataCount(member.getMemberIdx());
            int total_page = paginateUtil.pageCount(dataCount, size);
            int usedPoint = pointService.getUsedPoint();
            int pointEnabled = pointService.getPointEnabled(member.getMemberIdx());


            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;

            String cp = request.getContextPath();
            String listUrl = cp + "/coupon/detail";
            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            List<MemberPoint> userSaveAmount = pointService.getUserSaveAmount1(member.getMemberIdx());
            int saveAmount = pointService.getSaveAmount(member.getMemberIdx());

            model.addAttribute("paging", paging);
            model.addAttribute("page", current_page);
            model.addAttribute("size", size);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("total_page", total_page);
            model.addAttribute("userSaveAmount", userSaveAmount);
            model.addAttribute("usedPoint", usedPoint);
            model.addAttribute("saveAmount", saveAmount);
            model.addAttribute("pointEnabled", pointEnabled);
        } catch (Exception e){
            log.error("마이페이지 쿠폰.. 오류",e);
            return "redirect:/mypage/home";
        }

        return "mypage/pointDetail";

    }
}
