package com.sp.app.service;

import com.sp.app.common.StorageService;
import com.sp.app.mapper.UserImageMapper;
import com.sp.app.model.Review;
import com.sp.app.model.UserImage;
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
    public String uploadImage(MultipartFile file, UserImage dto) throws Exception {
        if(dto.getMemberIdx() == 0) {
            throw new Exception("세션값 없음.");
        }
        if(file == null || file.isEmpty()){
            throw new Exception("업로드할 파일이 없습니다.");
        }

        String savedFilename = storageService.uploadFileToServer(file, uploadPath);
        if(savedFilename == null){
            throw new Exception("파일 저장에 실패하였습니다.");
        }

        dto.setImageFileName(savedFilename);

        String imageFile = mapper.getProfileImageFile(dto.getMemberIdx());
        if(imageFile == null) {
            mapper.insertImage(dto);
        } else {
            mapper.updateImage(dto);
        }
        return savedFilename;
    }

    @Override
    public void insertImageReview(UserImage dto) throws Exception {
        try {
            mapper.insertImage(dto);
        } catch(Exception e) {
            log.info("insertImageReview", e);
        }
    }

    @Override
    public String getProfileImageFile(long memberIdx) {
        return mapper.getProfileImageFile(memberIdx);
    }
}
