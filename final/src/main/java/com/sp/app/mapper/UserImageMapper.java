package com.sp.app.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserImageMapper {
    // 이미지 파일명을 DB에 저장하는 메서드
    int insertImage(String imageFileName);
}