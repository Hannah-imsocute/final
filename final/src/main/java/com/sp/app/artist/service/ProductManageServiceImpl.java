package com.sp.app.artist.service;

import java.sql.SQLException;
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
	public void insertProduct(ProductManage dto, MultipartFile thumbnailFile, String uploadPath) {
		try {

			// 메인 이미지 업로드 처리
	        if (thumbnailFile != null && !thumbnailFile.isEmpty()) {
	            String mainFilename = storageService.uploadFileToServer(thumbnailFile, uploadPath);
	            dto.setThumbnail(mainFilename);
	        }
	        // 메인상품 저장
	        long productCode = mapper.seq_product();
			dto.setProductCode(productCode);
			mapper.insertProduct(dto);
			
			// 추가 이미지 저장
			// MultipartFile 뷰의 form 으로 전달받으면 기본값으로 size 가 1로 잡힘
			if(dto.getAddFiles() != null && !dto.getAddFiles().isEmpty()) {
			    insertProductImage(dto, uploadPath);
			}
			
			// 옵션처리 프로세스
			if(dto.getOptionCount() > 0) {
				// 부모 옵션 처리
				dto.setOption_price(dto.getPrice()); // 일단 옵션가격에 대한 정의가 애매하므로 우선 product의 제품가격을 그대로 사용
				
				long optionCode = mapper.seq_productOption(); // 부모 옵션코드 채번. 자식옵션은 이것을 parentcode로 사용
				dto.setOption_code(optionCode);

				mapper.insertProductOption(dto); // 부모 옵션등록
			    List<String> optionValues = dto.getOption_values();
			    if(optionValues != null) {
			    	for(String OptionValue : optionValues) {
			    		dto.setOption_value(OptionValue);
			    		mapper.insertProductOptionDetail(dto); // 부모 옵션상세 등록
			    	}
			    }
			    // 자식 옵션 처리
			    if(dto.getOptionCount() > 1) {
			    	long optionCode2 = mapper.seq_productOption(); // 자식 옵션코드 채번
			    	dto.setOption_code(optionCode2);
			    	dto.setOption_name(dto.getOption_name2());
			    	dto.setParent_option(optionCode); // 부모 옵션코드사용
			    	mapper.insertProductOption(dto); // 자식 옵션등록
			    	List<String> optionValues2 = dto.getOption_values2();
			    	if(optionValues2 != null) {
			    		for(String OptionValue2 : optionValues2) {
			    			dto.setOption_value(OptionValue2);
			    			mapper.insertProductOptionDetail(dto); // 자식 옵션상세 등록
			    		}
			    	}
			    }
			}
			
		}  catch (Exception e) {
			log.info("insertProduct : ", e);
			throw e;
		}
	}


	public void insertProductImage(ProductManage dto, String uploadPath) {
		for (MultipartFile mf : dto.getAddFiles()) {
			try {
				// MultipartFile 파일사이즈, 파일명 까지 체크.. 
				// 왜냐면 MultipartFile 뷰의 form 으로 전달받으면 기본값으로 size 가 1로 잡히기 때문에
				// 아예 꺼내서 파일사이즈 까지 체크해보고 비어있는지 확인해야함 
	            if( mf.getSize() > 0 
	            && mf.getOriginalFilename() != null 
	            && mf.getOriginalFilename().trim().isEmpty()) {
	            	String saveFilename = Objects.requireNonNull(storageService.uploadFileToServer(mf, uploadPath));
	            	if(saveFilename != null) {
	            		dto.setImageFileName(saveFilename);
	            		mapper.insertProductImage(dto); // 추가이미지 등록
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

}
