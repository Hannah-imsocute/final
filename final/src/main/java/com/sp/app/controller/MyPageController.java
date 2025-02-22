package com.sp.app.controller;

import com.sp.app.common.StorageService;
import com.sp.app.model.*;
import com.sp.app.service.*;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/mypage/*")
@Slf4j
public class MyPageController {

	private final CartItemService cartItemService;
	private final OrderService orderService;
	private final CouponService couponService;
	private final ShippingService shippingService;
	private final MemberService memberService;
	private final StorageService storageService;
	private final ImageUploadService imageUploadService;
//	private String uploadPath;
//
//	@PostConstruct
//	public void init() {
//		uploadPath = this.storageService.getRealPath("/uploads/mypage");
//	}


	@GetMapping("home")
	public String home(
			HttpSession session, Model model
	) {
		try {
			SessionInfo member = (SessionInfo) session.getAttribute("member");
			// 쿠폰 리스트 가져오기
			List<Coupon> couponList = orderService.getCouponList(member.getMemberIdx());
			MemberPoint userPoint = orderService.getLatestUserPoint(member.getMemberIdx());
			int couponCount = couponService.getCouponCount(member.getMemberIdx());
			Member userProfile = memberService.findByUserEmail(member.getEmail());
			String profileImageFile = memberService.getProfileImageFile(member.getMemberIdx());
			List<Map<String, Long>> productParams = new ArrayList<>();
			Map<String, Long> paramMap = new HashMap<>();
			paramMap.put("memberIdx", member.getMemberIdx());
			productParams.add(paramMap);

//			List<Order> orderList = orderService.listOrderProduct(productParams);

			model.addAttribute("couponList", couponList);
			model.addAttribute("couponCount", couponCount);
			model.addAttribute("userPoint", userPoint);
			model.addAttribute("userProfile", userProfile);
			model.addAttribute("profileImageFile", profileImageFile);

//			model.addAttribute("orderList", orderList);
		} catch(Exception e) {
			log.error("마이페이지  예외 발생", e);
		}
		return "mypage/home";
	}

	@PostMapping("image")
	@ResponseBody
	public Map<String, Object> image(
			HttpSession session,
			@RequestParam("profileFile") MultipartFile file,
			UserImage userImage
	) {
		Map<String, Object> map = new HashMap<>();
		try {
			SessionInfo info = (SessionInfo) session.getAttribute("member");
			if(info == null) {
				throw new Exception("로그인 정보가 없습니다.");
			}
			// 이미지 업로드 후 저장된 파일명 반환
			String savedFilename = imageUploadService.uploadImage(file);
			userImage.setImageFileName(savedFilename);
			// 기존 프로필 이미지 파일 조회 (memberService에서 해당 회원의 프로필 이미지 파일명을 반환)
//			String profileImageFile = memberService.getProfileImageFile(info.getMemberIdx());

			map.put("success", true);
			map.put("image", savedFilename);
		} catch(Exception e) {
			log.error("프로필 이미지 업로드 에러 발생", e);
			map.put("error", e.getMessage());
		}
		return map;
	}

}
