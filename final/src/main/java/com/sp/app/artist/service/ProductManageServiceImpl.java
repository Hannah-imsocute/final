package com.sp.app.artist.service;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.artist.mapper.ProductManageMapper;
import com.sp.app.artist.model.ProductManage;
import com.sp.app.common.StorageService;
import com.sp.app.exception.StorageException;

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

			// 메인 이미지 업로드 처리
	        if (dto.getThumbnailFile() != null && !dto.getThumbnailFile().isEmpty()) {
	        	// String originFileName = dto.getThumbnailFile().getOriginalFilename(); 원본파일명 컬럼추가되면 로직 살리기
	            String mainFilename = storageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
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
	            && !mf.getOriginalFilename().trim().isEmpty()) {
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

	@Override
	public List<ProductManage> listProduct(Map<String, Object> map) {
		List<ProductManage> list = null;
		try {
			list = mapper.listProduct(map);
			
			int discountPrice; //할인되는 가격
			for(ProductManage dto : list) {
				discountPrice = 0;
				if(dto.getDiscount()>0) {
					discountPrice = (int)(dto.getPrice() * dto.getDiscount()/100);
				}
				dto.setSalePrice(dto.getPrice() - discountPrice);
			}
			
			
		} catch (Exception e) {
			log.info("listProduct : ", e);
		} 
		
		return list;
	}

	@Override
	public void deleteProduct(long productCode) {
		try {
			mapper.deleteProduct(productCode);
			mapper.deleteOrderitem(productCode);
			mapper.deletePackage(productCode);
			mapper.deleteProductimage(productCode);
			mapper.deleteCartitem(productCode);
			mapper.deleteProductoption(productCode);
		} catch (Exception e) {
			log.info("deleteProduct");
		}
		
	}

	@Override
	public ProductManage findById(long productCode) {
		ProductManage dto = null;
		try {
			dto = mapper.findById(productCode);
		} catch (Exception e) {
			log.info("findById :", e);
		}	
		return dto;
	}

	@Override
	public List<ProductManage> listAddFiles(long productCode) {
		List<ProductManage> list = null;
		try {
			list = mapper.listAddFiles(productCode);
		} catch (Exception e) {
			log.info("listAddFiles : ", e);
		}
		return list;
	}

	@Transactional(rollbackFor = {Exception.class})
	@Override
	public void updateProduct(ProductManage dto, String uploadPath) {
		try {
			String filename = storageService.uploadFileToServer(dto.getThumbnailFile(), uploadPath);
			if(filename != null) {
				if(!dto.getThumbnail().isBlank()) {
					deleteUploadFile(uploadPath, dto.getThumbnail());
				}
				dto.setThumbnail(filename);
				
			}
			
			mapper.updateProduct(dto);

			// 추가 이미지
			if(! dto.getAddFiles().isEmpty()) {
				insertProductImage(dto, uploadPath);
			}
			
			//옵션 수정
			updateProductOption(dto);
			
			
		} catch (Exception e) {
			log.info("updateProduct :", e);
		}
		
	}

	@Override
	public boolean deleteUploadFile(String uploadPath, String filename) {
		return storageService.deleteFile(uploadPath, filename);
	}
	
	

	@Override
	public void deleteProductFile(long image_code, String pathString) {
		try {
			if (pathString != null && pathString.isBlank()) {
				storageService.deleteFile(pathString);
			}
			mapper.deleteProductFile(image_code);
			
		} catch (Exception e) {
			log.info("deleteProductFile : ", e);
			
			throw e;
		}
		
	}

	@Override
	public void updateProductOption(ProductManage dto) {
		try {
			if(dto.getOptionCount() == 0) {
				// 기존 옵션1, 옵션2 삭제
				if(dto.getPrevOption_code2() != 0) {
//					mapper.deleteOptionDetail2(dto.getPrevOption_code2());
//					mapper.deleteProductOption(dto.getPrevOption_code2());
				}
				
				if(dto.getPrevOption_code() != 0) {
//					mapper.deleteOptionDetail2(dto.getPrevOption_code());
//					mapper.deleteProductOption(dto.getPrevOption_code());
				}
				
				return;
			} else if(dto.getOptionCount() == 1) {
				// 기존 옵션 2 삭제
				if(dto.getPrevOption_code2() != 0) {
//					mapper.deleteOptionDetail2(dto.getPrevOption_code2());
//					mapper.deleteProductOption(dto.getPrevOption_code2());
				}
			}
			
			long detailCode, parentCode;
			
			// 옵션1 -----
			// 옵션1이 없는 상태에서 옵션1을 추가한 경우
			if(dto.getOption_code() == 0) {
			// 부모 옵션 처리		
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
	
		return;
	}
			// 옵션1이 존재하는 경우 옵션1 수정
//			mapper.updateProductOption(dto);
			
			// 기존 옵션1 옵션값 수정
			int size = dto.getOptionDetail_codes().size();
			for(int i = 0; i < size; i++) {
				dto.setOptionDetail_code(dto.getOptionDetail_codes().get(i));
				dto.setOption_value(dto.getOption_values().get(i));
//				mapper.updateOptionDetail(dto);
			}

			// 새로운 옵션1 옵션값 추가
			dto.setOptionDetail_codes(new ArrayList<Long>());
			for(int i = size; i < dto.getOptionDetail_codes().size(); i++) {
//				detailCode = mapper.detailSeq(); 
//				dto.setOptionDetail_code(detailCode);
				dto.setOption_value(dto.getOption_values().get(i));
//				mapper.insertOptionDetail(dto);
				
//				dto.getOptionDetail_codes().add(detailCode);
			}

			// 옵션2 -----
			if(dto.getOptionCount() > 1) {
				//  옵션2가 없는 상태에서 옵션2를 추가한 경우
				parentCode = dto.getOption_code(); // 옵션1 옵션번호 
				if(dto.getOption_code2() == 0) {
//					long optionCode2 = mapper.optionSeq();
//					dto.setOptionCode(optionCode2);
//					dto.setOptionName(dto.getOptionName2());
//					dto.setParentOption(parentNum);
					mapper.insertProductOption(dto);
					
					// 옵션 2 값 추가
					dto.setOptionDetail_codes2(new ArrayList<Long>());
					for(String optionValue2 : dto.getOption_values2()) {
//						detailCode = mapper.detailSeq(); 
//						dto.setOptionDetail_code(detailCode);
						dto.setOption_value(optionValue2);
//						mapper.insertOptionDetail(dto);
						
//						dto.getOptionDetail_codes2().add(detailCode);
					}
					
					return;
				} 
				
				// 옵션2 가 존재하는 경우 옵션2 수정
				dto.setOption_code(dto.getOption_code2());
				dto.setOption_name(dto.getOption_name2());
//				mapper.updateProductOption(dto);
				
				// 기존 옵션2 옵션값 수정
				int size2 = dto.getOptionDetail_codes2().size();
				for(int i = 0; i < size2; i++) {
					dto.setOptionDetail_code(dto.getOptionDetail_codes2().get(i));
					dto.setOption_value(dto.getOption_values2().get(i));
//					mapper.updateOptionDetail(dto);
				}
	
				// 새로운 옵션2 옵션값 추가
				dto.setOptionDetail_codes2(new ArrayList<Long>());
				for(int i = size2; i < dto.getOption_values2().size(); i++) {
//					detailCode = mapper.detailSeq(); 
//					dto.setOptionDetail_code(detailCode);
					dto.setOption_value(dto.getOption_values2().get(i));
//					mapper.insertOptionDetail(dto);
					
//					dto.getOptionDetail_codes2().add(detailCode);
				}
			}
		} catch (Exception e) {
			log.info("updateProductOption : ", e);
			
			throw e;
		}
	}
	
	@Override
	public void insertProductOption(ProductManage dto) {
		
	}

}
