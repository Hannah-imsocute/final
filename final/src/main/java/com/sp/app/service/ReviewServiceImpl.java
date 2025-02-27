package com.sp.app.service;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.ReviewMapper;
import com.sp.app.model.MemberPoint;
import com.sp.app.model.MyPage;
import com.sp.app.model.Review;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReviewServiceImpl implements ReviewService{

    private final ReviewMapper mapper;
    private final PointService pointService;
    private final StorageService storageService;

    // 리뷰 작성
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void insertReview(Review dto, String uploadPath) throws SQLException {
        try {
            dto.setMemberIdx(dto.getMemberIdx());
            dto.setProductCode(dto.getProductCode());
            dto.setReviewNum(dto.getReviewNum());
            dto.setImage(uploadPath);
            dto.setContent(dto.getContent());
            dto.setBlock(0);

            mapper.insertReview(dto); // 리뷰 작성

            MemberPoint point = MemberPoint.builder()
                    .memberIdx(dto.getMemberIdx())
                    .reason("리뷰 적립")
                    .saveAmount(50)
                    .balance(50)
                    .build();

            if(dto.getSelectFile() == null) {
                dto.setImage(dto.getImage());
                mapper.insertImageReview(dto);

                point.setSaveAmount(100);
                point.setBalance(100);
            }
            pointService.insertReviewPoint(point); // 리뷰 포인트 작성 해주는곳
        } catch (Exception e) {
            log.error("insertReview", e);
        }
    }


    @Override
    public void deleteReview(long num, String uploadPath) throws Exception {
        try {
            List<Review> reviews = mapper.listReviewFile(num);
            if(reviews != null) { // 이미지가 있으면 이미지 먼저 삭제하고 나서 리뷰 삭제
                for (Review dto : reviews) {
                    storageService.deleteFile(uploadPath, dto.getImage());
                }
            }

            mapper.deleteReview(num);
        } catch(Exception e) {
            log.info("deleteReview", e);
        }
    }

    @Override
    public void updateReview(Review dto) throws Exception {
        try {
            mapper.updateReview(dto);
        } catch(Exception e) {
            log.info("updateReview", e);
        }
    }

    @Override
    public List<Review> listReview(Map<String, Object> map) {
        List<Review> list = null;

        try {
            list = mapper.getlistReview(map);

            for (Review dto : list) {
                if(dto.getImage() != null) { // 이미지가 존재하면
                    dto.setListFilename(dto.getImage().split(","));
                }
                dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
            }
        } catch(Exception e) {
            log.info("listReview", e);
        }
        return list;
    }

    @Override
    public int dataCount(long num) {
        return mapper.dataCount(num);
    }

    @Override
    public List<MyPage> getReviewHistory(long num) {
        return mapper.getReviewHistory(num);
    }

    @Override
    public Review getReviewUpdateNum(long reviewNum) {
        Review updatedReview = null;
        try {
            updatedReview = mapper.getReviewUpdateNum(reviewNum);
        } catch(Exception e) {
            log.info("getReviewUpdateNum", e);
        }
        return updatedReview;
    }


}
