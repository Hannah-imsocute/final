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
import org.springframework.web.multipart.MultipartFile;

import java.sql.SQLException;
import java.util.ArrayList;
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
            // 리뷰 작성
            dto.setBlock(0);
            mapper.insertReview(dto);

            // 리뷰 이미지 등록 파일이 있을 경우에만
            if (dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
                List<MultipartFile> files = dto.getSelectFile();
                for (MultipartFile file : files) {
                    String fileName = storageService.uploadFileToServer(file, uploadPath);
                    dto.setImage(fileName);
                    mapper.insertImageReview(dto);
                }
            }
            // 리뷰 포인트 적립
            int saveAmount = (dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) ? 100 : 50;
            MemberPoint point = MemberPoint.builder()
                    .memberIdx(dto.getMemberIdx())
                    .reason("리뷰 적립")
                    .saveAmount(saveAmount)
                    .balance(saveAmount)
                    .build();
            pointService.insertReviewPoint(point);

        } catch (Exception e) {
            log.error("insertReview error", e);
        }
    }

    @Transactional(rollbackFor = Exception.class)
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
            throw e;
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateReview(Review dto, String uploadPath) throws Exception {
        try {

            if(dto.getSelectFile() != null && !dto.getSelectFile().isEmpty()) {
                if (dto.getImage() != null && !dto.getImage().isEmpty()) {
                    String[] oldFiles = dto.getImage().split(",");
                    for (String oldFile : oldFiles) {
                        storageService.deleteFile(uploadPath, oldFile.trim());
                    }
                }
                List<MultipartFile> newFiles = dto.getSelectFile();
                List<String> storedFileNames = new ArrayList<>();
                for (MultipartFile file : newFiles) {
                    String newFileName = storageService.uploadFileToServer(file, uploadPath);
                    storedFileNames.add(newFileName);
                    dto.setImage(newFileName);
                    mapper.insertImageReview(dto);
                }
                String joinedFileNames = String.join(",", storedFileNames);
                dto.setImage(joinedFileNames);
            }
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

    @Override
    public List<Review> listReviewFile(Review review) {

        return mapper.listReviewFile(review.getReviewNum());
    }


}
