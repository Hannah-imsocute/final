package com.sp.app.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.artist.model.ProductManage;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.mapper.CommunityMapper;
import com.sp.app.model.Community;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CommunityServiceImpl implements CommunityService{
	private final CommunityMapper mapper;
	private final StorageService storageService;

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Community findById(long num) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Community> listCommunity(Map<String, Object> map) throws Exception {
		List<Community> list = null;

		try {
			list = mapper.listCommunity(map);
		} catch (Exception e) {
			log.info("listCommunity : ", e);
		}
		return list;
	}

	@Override
	public void insertCommunity(Community dto, String uploadPath) throws Exception {
		try {
			mapper.insertCommunity(dto, uploadPath);
			
			if(dto.getImages() != null && !dto.getImages().isEmpty()) {
				insertCommunityImage(dto, uploadPath);
			}
		} catch (Exception e) {
			log.info("insertCommunity : ", e);
		}
	}
		
    
	@Override
	public void insertCommunityImage(Community dto, String uploadPath) throws Exception{
		for (MultipartFile mf : dto.getImages()) {
			try {
				// MultipartFile 파일사이즈, 파일명 까지 체크.. 
				// 왜냐면 MultipartFile 뷰의 form 으로 전달받으면 기본값으로 size 가 1로 잡히기 때문에
				// 아예 꺼내서 파일사이즈 까지 체크해보고 비어있는지 확인해야함 
	            if( mf.getSize() > 0 
	            && mf.getOriginalFilename() != null 
	            && !mf.getOriginalFilename().trim().isEmpty()) {
	            	String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
	            	if(saveFilename != null) {
	            		dto.setSaveFileName(saveFilename);
	            		dto.setOriginal_FileName(mf.getOriginalFilename());
	            		mapper.insertCommunityImage(dto, uploadPath); // 이미지 등록
	            	}				
	            }
				
			} catch (NullPointerException e) {
				throw e;
			} catch (StorageException e) {
				throw e;
			} catch (Exception e) {
				throw e;
			}
		}
	}

	@Override
	public void updateCommunity(Community dto, String uploadPath) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCommunity(long num, String uploadPath, String memberIdx, String AUTHORITY) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateHitCount(long num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Community findByPrev(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Community findByNext(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}



	
}
