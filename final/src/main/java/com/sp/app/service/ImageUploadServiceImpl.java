package com.sp.app.service;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.UserImageMapper;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
@Slf4j

public class ImageUploadServiceImpl implements ImageUploadService{
    private final UserImageMapper mapper;
    private final StorageService storageService;
    private String uploadPath;

    @PostConstruct
    public void init() {
        this.uploadPath = storageService.getRealPath("/uploads/mypage");
    }

    @Override
    public String uploadImage(MultipartFile file) throws Exception {
        if(file == null || file.isEmpty()){
            throw new Exception("업로드할 파일이 없습니다.");
        }
        // 파일 저장 및 저장된 파일명 반환
        String savedFilename = storageService.uploadFileToServer(file, uploadPath);
        if(savedFilename == null){
            throw new Exception("파일 저장에 실패하였습니다.");
        }
        // DB에 이미지 파일명 저장 (기본 이미지 테이블에 저장)
        mapper.insertImage(savedFilename);
        return savedFilename;
    }
}
