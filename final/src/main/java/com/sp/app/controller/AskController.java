package com.sp.app.controller;

import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Ask;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.AskService;
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
@RequiredArgsConstructor
@RequestMapping("/ask/*")
@Slf4j
public class AskController {
    private final AskService askService;
    private final PaginateUtil paginateUtil;

    @GetMapping("list")
    public String list(
            @RequestParam(value = "page",defaultValue = "1") int current_page,
            @RequestParam(value = "kwd", defaultValue = "", required = false) String kwd,
            HttpSession session, HttpServletRequest request, Model model){
        try {
            SessionInfo member = (SessionInfo) session.getAttribute("member");

            int size = 5;
            int dataCount = 0;

            dataCount = askService.dataCount(member.getMemberIdx());

            int total_page = paginateUtil.pageCount(dataCount, size);
            current_page =  Math.min(current_page, total_page);

            String cp = request.getContextPath();
            String listUrl = cp + "/ask/list";
            String paging = paginateUtil.paging(current_page, total_page, listUrl);

            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;

            Map<String, Object> map = new HashMap<>();
            map.put("offset", offset);
            map.put("size", size);
            map.put("memberIdx", member.getMemberIdx());

            List<Ask> askList = askService.getAskList(map);

            model.addAttribute("paging", paging);
            model.addAttribute("dataCount", dataCount);
            model.addAttribute("total_page", total_page);
            model.addAttribute("askList", askList);
            model.addAttribute("page", current_page);

        } catch(Exception e) {
            log.error("문의하기 내역 불러오던 중 오류 발생..", e);
        }

        return "mypage/ask";
    }

    @PostMapping("submit")
    public String insertAsk(@ModelAttribute Ask ask) {
        try {
            askService.insertAsk(ask);
        } catch (Exception e) {
            log.error("상품 문의 중 예외 발생", e);
        }
        return "redirect:/mypage/detail";
    }
}
