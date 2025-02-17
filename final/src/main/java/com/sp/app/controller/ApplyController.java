package com.sp.app.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sp.app.admin.model.ApplyManage;
import com.sp.app.admin.service.ApplyManageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/main/*")
public class ApplyController {
    private final ApplyManageService service;

    @GetMapping("")
    public String showApplicationForm() {
        return "main/write";
    }

    @PostMapping("write")  // ⭐ 입점 신청 처리
    public String insertApply(
    		ApplyManage dto,
            Model model) {

        try {
            // 데이터 저장
            service.insertApply(dto);

            model.addAttribute("message", "입점 신청이 완료되었습니다!");
            return "redirect:/"; // 성공 후 다시 폼 페이지로 이동
        } catch (Exception e) {
            model.addAttribute("error", "신청 중 오류 발생");
            return "main/write"; // 에러 발생 시 원래 페이지로 이동
        }
    }
}

