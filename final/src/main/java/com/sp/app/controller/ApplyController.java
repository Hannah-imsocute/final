package com.sp.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.admin.mapper.ApplyManageMapper;
import com.sp.app.admin.model.ApplyManage;

@Controller
@RequestMapping("/main")
public class ApplyController {

    @Autowired
    private ApplyManageMapper applyManageMapper;

    @GetMapping("/write")
    public String showApplicationForm() {
        return "write";
    }

    @PostMapping("/apply")  // ⭐ 입점 신청 처리
    public String submitApplication(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam("brandname") String brandname,
            @RequestParam("brandintro") String brandintro,
            @RequestParam("intropeice") String intropeice,
            @RequestParam("forextra") String forextra,
            @RequestParam("agreed") String agreed,
            Model model) {

        try {
            // DTO 객체 생성
            ApplyManage dto = new ApplyManage();
            dto.setName(name);
            dto.setEmail(email);
            dto.setPhone(phone);
            dto.setBrandName(brandname);
            dto.setBrandName(brandintro);
            dto.setIntroPeice(intropeice);
            dto.setForExtra(forextra);
            dto.setAgreed(agreed);

            // 데이터 저장
            applyManageMapper.insertApply(dto);

            model.addAttribute("message", "입점 신청이 완료되었습니다!");
            return "redirect:/main/write"; // 성공 후 다시 폼 페이지로 이동
        } catch (Exception e) {
            model.addAttribute("error", "신청 중 오류 발생");
            return "write"; // 에러 발생 시 원래 페이지로 이동
        }
    }
}

