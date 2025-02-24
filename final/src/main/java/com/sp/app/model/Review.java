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
  private long productCode; // 상품번호
  private String content; // 내용
  private int block;
  private int starRate; // 별점
  private String image;
  private long reviewImgNum; // 리뷰이미지번호

  private String[] listFilename;
  private List<MultipartFile> selectFile; // 이미지 파일



}
