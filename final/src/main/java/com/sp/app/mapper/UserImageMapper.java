package com.sp.app.mapper;

import com.sp.app.model.UserImage;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserImageMapper {
    // 이미지 파일명을 DB에 저장하는 메서드
    void insertImage(UserImage dto);
    void updateImage(UserImage dto);
    String getProfileImageFile(long memberIdx);
}