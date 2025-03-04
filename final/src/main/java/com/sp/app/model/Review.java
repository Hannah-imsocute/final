package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Review {
  private long reviewNum; // 리뷰번호
  private long memberIdx;
  private long itemCode;
  private long productCode; // 상품번호
  private String content; // 내용
  private int block;
  private int starRate; // 별점
  private int item; // 상품이름
  private String image;
  private String productName; // 상품이름
  private String brandName;
  private long reviewImgNum; // 리뷰이미지번호
  private int reviewCount; // 리뷰 썼는지 안 썼는지 확인
  private String thumbnail;

  private String[] listFilename;
  private List<MultipartFile> selectFile; // 이미지 파일



}
