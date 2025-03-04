package com.sp.app.service;

import com.sp.app.model.MyPage;
import com.sp.app.model.Review;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface ReviewService {
    void insertReview(Review dto, String uploadPath) throws Exception; // 리뷰 작성
    void deleteReview(long num, String uploadPath) throws Exception; // 리뷰 삭제
    void updateReview(Review dto, String uploadPath) throws Exception; // 리뷰 수정
    List<Review> listReview(Map<String, Object> map); // 리뷰 찾기
    int dataCount(long num); // 리뷰 개수

    List<MyPage> getReviewHistory(long num); // 중복리뷰 막기
    Review getReviewUpdateNum(long reviewNum);
    List<Review>listReviewFile(Review review);



}
