package com.sp.app.controller;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.MemberPoint;
import com.sp.app.model.MyPage;
import com.sp.app.model.Review;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MyPageService;
import com.sp.app.service.ReviewService;
import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/review/*")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    private final ReviewService reviewService;
    private final StorageService storageService;
    private final PaginateUtil paginateUtil;

    private String uploadPath;

    @PostConstruct
    public void init() {
        uploadPath = this.storageService.getRealPath("/uploads/review");
    }

    @PostMapping("write")
    @ResponseBody
    public ResponseEntity<?> createReview(@ModelAttribute Review review, @ModelAttribute MemberPoint point) {
        Map<String, Object> result = new HashMap<>();
        try {
            reviewService.insertReview(review, uploadPath);
            result.put("success", true);
            result.put("message", "리뷰가 등록되었습니다.");
            return new ResponseEntity<>(result, HttpStatus.OK);
        } catch (Exception e) {
            log.error("리뷰 등록 중 예외 발생", e);
            result.put("success", false);
            result.put("message", "리뷰 등록 실패");
            return new ResponseEntity<>(result, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    /**
     * 리뷰 수정
     */
    @GetMapping("detail/{reviewNum}")
    @ResponseBody
    public ResponseEntity<?> getReviewDetail(@PathVariable("reviewNum") long reviewNum) {
        try {
            Review review = reviewService.getReviewUpdateNum(reviewNum);

            return new ResponseEntity<>(review, HttpStatus.OK);
        } catch (Exception e) {
            log.error("[getReviewDetail] 리뷰 조회 중 예외 발생", e);
            return new ResponseEntity<>("리뷰 조회 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("edit/{reviewNum}")
    @ResponseBody
    public ResponseEntity<?> updateReview(
            @PathVariable("reviewNum") long reviewNum, Review dto
    ) {
        try {
            reviewService.updateReview(dto);
            return new ResponseEntity<>("리뷰가 수정되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            log.error("[updateReview] 리뷰 수정 중 예외 발생", e);
            return new ResponseEntity<>("리뷰 수정 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    /**
     * 리뷰삭제
     */
    @DeleteMapping("{reviewNum}")
    @ResponseBody
    public ResponseEntity<?> deleteReview(@PathVariable("reviewNum") long reviewNum) {
        try {
            reviewService.deleteReview(reviewNum, uploadPath);
            return new ResponseEntity<>("리뷰가 삭제되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            log.error("[deleteReview] 리뷰 삭제 중 예외 발생", e);
            return new ResponseEntity<>("리뷰 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("list")
    public String listReview(
            @RequestParam(value="page", defaultValue="1") int current_page,
            HttpSession session, Model model, HttpServletRequest request
    ) {
        try {
            SessionInfo member = (SessionInfo) session.getAttribute("member");
            int size = 5;
            int dataCount = 0;

            long memberIdx = member.getMemberIdx();

            dataCount = reviewService.dataCount(memberIdx);

            int total_page = paginateUtil.pageCount(dataCount, size);
            current_page =  Math.min(current_page, total_page);

            String cp = request.getContextPath();
            String listUrl = cp + "/review/list";
            String paging = paginateUtil.paging(current_page, total_page, listUrl);
            int offset = (current_page - 1) * size;
            if(offset < 0) offset = 0;

            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("memberIdx", memberIdx);
            paramMap.put("offset", offset);
            paramMap.put("size", size);
            List<Review> list = reviewService.listReview(paramMap);

            model.addAttribute("paging", paging);
            model.addAttribute("page", current_page);
            model.addAttribute("total_page", total_page);
            model.addAttribute("offset", offset);
            model.addAttribute("size", size);
            model.addAttribute("reviewList", list);
        } catch (Exception e) {
            log.error("[listReview] 리뷰 목록 조회 중 예외 발생", e);
        }

        return "review/list";
    }

}