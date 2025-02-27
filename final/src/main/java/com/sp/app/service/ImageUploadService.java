package com.sp.app.service;

import com.sp.app.model.UserImage;
import org.springframework.web.multipart.MultipartFile;

public interface ImageUploadService {
    String uploadImage(MultipartFile file, UserImage dto) throws Exception;
    void insertImageReview(UserImage dto) throws Exception;
    String getProfileImageFile(long memberIdx);
}
