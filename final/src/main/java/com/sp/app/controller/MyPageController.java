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
	private final PointService pointService;
	private final MyPageService myPageService;

//	private String uploadPath;
//
//	@PostConstruct
//	public void init() {
//		uploadPath = this.storageService.getRealPath("/uploads/mypage");
//	}



public String getUserProfile(HttpSession session, Model model) {
  try {
    SessionInfo member = (SessionInfo) session.getAttribute("member");
    Member userProfile = memberService.findByUserEmail(member.getEmail());
		model.addAttribute("userProfile", userProfile);
  } catch (Exception e) {
    throw new RuntimeException(e);
  }

  return "mypage/sidebar";
}

//	@ModelAttribute("profileImageFile")
//	public String getProfileImageFile(@ModelAttribute("userProfile") Member userProfile) {
//		return userProfile.get();
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
			List<Map<String, Long>> productParams = new ArrayList<>();
			Map<String, Long> paramMap = new HashMap<>();
			paramMap.put("memberIdx", member.getMemberIdx());
			productParams.add(paramMap);
			int balance = pointService.getPointEnabled(member.getMemberIdx());
			List<myPage> ordersHistory = myPageService.getOrdersHistory(member.getMemberIdx());
			for (myPage item : ordersHistory) {
				model.addAttribute("orderDate", item.getOrderDate());
			}
			model.addAttribute("balance", balance); // 현재 사용할 수 있는 포인트 금액
			model.addAttribute("couponList", couponList); // 쿠폰 리스트
			model.addAttribute("couponCount", couponCount); // 쿠폰 개수
			model.addAttribute("userPoint", userPoint);
			model.addAttribute("userProfile", userProfile);
			model.addAttribute("ordersHistory", ordersHistory);

//			model.addAttribute("orderList", orderList);
		} catch(Exception e) {
			log.error("마이페이지  예외 발생", e);
		}
		return "mypage/home1";
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

	@GetMapping("detail")
	public String detail(HttpSession session, Model model) {
    try {
      SessionInfo member = (SessionInfo) session.getAttribute("member");
      List<myPage> ordersHistory = myPageService.getOrdersHistory(member.getMemberIdx());
			model.addAttribute("ordersHistory", ordersHistory);
    } catch (Exception e) {
			log.error("detail", e);
			throw new RuntimeException(e);
    }
    return "mypage/detail";
	}


	// 리뷰

	@GetMapping("review/main")
	public String review(Review review) {

	return "review/list";
	}

	@GetMapping("review/form")
	public String reviewForm(
			@RequestParam(value = "mode", required = false) String mode,
			Model model, HttpSession session) {
    try {
      SessionInfo member = (SessionInfo) session.getAttribute("member");
      List<myPage> ordersHistory = myPageService.getOrdersHistory(member.getMemberIdx());
      model.addAttribute("ordersHistory", ordersHistory);
			for (myPage item : ordersHistory) {
				String productName = item.getProductName();
				String thumbnail = item.getThumbnail();

				model.addAttribute("productName", productName);
				model.addAttribute("productImage", thumbnail);
				model.addAttribute("productImage", thumbnail);
			}
    } catch (Exception e) {
			log.error("폼 작성 중 오류 발생", e);
      throw new RuntimeException(e);
    }
    return "review/form";
	}

	@GetMapping("review/write")
	public String reviewWrite(Review review) {

		return "review/write";
	}






}
