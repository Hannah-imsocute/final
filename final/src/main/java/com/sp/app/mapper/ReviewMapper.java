package com.sp.app.mapper;

import com.sp.app.model.Review;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper

public interface ReviewMapper {

    // 상품평 작성하기
    void insertReview(Review review) throws SQLException;

    // 이미지 파일 넣기
    void insertImageReview(Review review) throws SQLException;

    // 리뷰 수정
    void updateReview(Review dto) throws SQLException;

    // 상품평 삭제하기
    void deleteReview(long num) throws SQLException;

    // 리뷰 목록 보기
    List<Review> getlistReview(Map<String, Object> map); // 리뷰 찾기
    // 리뷰 이미지 보기
    List<Review>listReviewFile(long num);
    // 리뷰 개수
    int dataCount();


}
