package com.sp.app.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
@Slf4j
public class AdminController {

	// 페이지 로드 요청 처리
	@GetMapping("/loadPage")
	@ResponseBody
	public String loadPage(@RequestParam("page") String page, Model model) {
		log.info("페이지 요청: {}", page);

		// 허용된 페이지 리스트
		String[] allowedPages = { "authList", "applyList", "membershipList", "paymentList", "productList", "eventList",
				"noticeList", "inquiryList", "reportList", "statsList" };

		// 요청한 페이지가 허용된 페이지 목록에 있는지 확인
		for (String allowedPage : allowedPages) {
			if (allowedPage.equals(page)) {
				return "admin/" + page; // 해당 페이지 반환
			}
		}

		// 허용되지 않은 페이지일 경우 기본 페이지로 이동 (ex. 로그인 페이지)
		return "admin/login";
	}
}