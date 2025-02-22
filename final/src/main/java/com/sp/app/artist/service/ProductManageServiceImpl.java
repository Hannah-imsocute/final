package com.sp.app.artist.service;

import java.util.List;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.artist.mapper.ProductManageMapper;
import com.sp.app.artist.model.ProductManage;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;
import com.sp.app.model.MainProduct;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ProductManageServiceImpl implements ProductManageService{
	public final ProductManageMapper mapper;
	private final StorageService storageService;

	@Override
	public ProductManage findByCategoryId(int CategoryCode) {
		ProductManage dto = null;
		try {
			dto = mapper.findByCategoryId(CategoryCode);
	
		} catch (Exception e) {
			log.info("findByCategoryId : ", e);
		}
		return dto;
	}

	@Override
	public List<ProductManage> listMainCategory() {
		List<ProductManage> list = null;
		
		try {
			list = mapper.listMainCategory();
		} catch (Exception e) {
			log.info("listCategory : ", e);
		}
				
		return list;
	}

	@Override
	public List<ProductManage> listSubCategory(long parentCategoryCode) {
		List<ProductManage> list = null;
		
		try {
			list = mapper.listSubCategory(parentCategoryCode);
		} catch (Exception e) {
			log.info("listSubCategory : ", e);
		}
		return list;
	}


	@Override
	public List<ProductManage> listProductOption(long productCode) {
		List<ProductManage> list = null;
		try {
			list = mapper.listProductOption(productCode);
		} catch (Exception e) {
			log.info("listProductOption : " , e);
		}
		return list;
	}

	@Override
	public List<ProductManage> listOptionDetail(long option_code) {
		List<ProductManage> list = null;
		try {
			list = mapper.listOptionDetail(option_code);
		} catch (Exception e) {
			log.info("listOptionDetail : " , e);
		}
		return list;
	}



	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void insertProduct(ProductManage dto, String uploadPath) {
		try {
			// 썸네일 이미지
	//		String filename = StorageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
	//		dto.setThumbnail(filename);
			
			// 상품 저장
			long productCode = mapper.seq_product();
			
			dto.setProductCode(productCode);
			mapper.insertProduct(dto);
			
			// 추가 이미지 저장
			if(! dto.getAddFiles().isEmpty()) {
				insertProductFile(dto, uploadPath);
			}
			
			// 옵션추가
			if(dto.getOptionCount() > 0) {
		//		insertProductOption(dto);
			}
			
		} catch (Exception e) {
			log.info("insertProduct : ", e);
			
			throw e;
		}
	}


	public void insertProductFile(ProductManage dto, String uploadPath) {
		for (MultipartFile mf : dto.getAddFiles()) {
			try {
				String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
				dto.setImageFileName(saveFilename);
				
				mapper.insertProductFile(dto);
			} catch (NullPointerException e) {
				throw e;
			} catch (StorageException e) {
				throw e;
			} catch (Exception e) {
				throw e;
			}
		}
	}




}
