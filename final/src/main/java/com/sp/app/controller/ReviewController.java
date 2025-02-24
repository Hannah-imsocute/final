package com.sp.app.controller;

import com.sp.app.common.StorageService;
import com.sp.app.model.Review;
import com.sp.app.service.ReviewService;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
@RequestMapping("/review/*")
@RequiredArgsConstructor
@Slf4j
public class ReviewController {

    private final ReviewService reviewService;
    private final StorageService storageService;

    private String uploadPath;

    @PostConstruct
    public void init() {
        uploadPath = this.storageService.getRealPath("/uploads/review");
    }

    @PostMapping("write")
    public ResponseEntity<?> createReview(@ModelAttribute Review dto) {
        Map<String, Object> result = new HashMap<>();
        try {
            reviewService.insertReview(dto, uploadPath);
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
    @PutMapping("/{reviewNum}")
    public ResponseEntity<?> updateReview(
            @PathVariable("reviewNum") long reviewNum,
            @RequestBody Review dto
    ) {
        try {
            // PathVariable로 받은 reviewNum을 DTO에 세팅
            dto.setReviewNum(reviewNum);
            reviewService.updateReview(dto);
            return new ResponseEntity<>("리뷰가 수정되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            log.error("[updateReview] 리뷰 수정 중 예외 발생", e);
            return new ResponseEntity<>("리뷰 수정 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @DeleteMapping("/{reviewNum}")
    public ResponseEntity<?> deleteReview(@PathVariable("reviewNum") long reviewNum) {
        try {
            reviewService.deleteReview(reviewNum, uploadPath);
            return new ResponseEntity<>("리뷰가 삭제되었습니다.", HttpStatus.OK);
        } catch (Exception e) {
            log.error("[deleteReview] 리뷰 삭제 중 예외 발생", e);
            return new ResponseEntity<>("리뷰 삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/list")
    public ResponseEntity<List<Review>> listReview(
            @RequestParam(value="memberIdx", required=false) Long memberIdx,
            @RequestParam(value="page", defaultValue="1") int page,
            @RequestParam(value="size", defaultValue="10") int size
    ) {
        try {
            int offset = (page - 1) * size;

            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("memberIdx", memberIdx);
            paramMap.put("offset", offset);
            paramMap.put("size", size);

            List<Review> list = reviewService.listReview(paramMap);
            return new ResponseEntity<>(list, HttpStatus.OK);
        } catch (Exception e) {
            log.error("[listReview] 리뷰 목록 조회 중 예외 발생", e);
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

}