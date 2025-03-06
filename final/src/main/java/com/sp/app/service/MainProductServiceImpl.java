package com.sp.app.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MainProductMapper;
import com.sp.app.model.MainProduct;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class MainProductServiceImpl implements MainProductService{
	private final MainProductMapper mapper;
	
	@Override
	public int totalDataCount(Map<String, Object> map) {
        int result = 0;
		
		try {
			result = mapper.totalDataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}


	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = mapper.dataCount(map);
		} catch (Exception e) {
			log.info("dataCount : ", e);
		}
		return result;
	}
	
	
	// 카테고리별 작품 조회 초화면(메인)
	@Override
	public List<MainProduct> listCategoryMainProduct(Map<String, Object> map) {
		List<MainProduct> list = null;
		
		try {
			list = mapper.listCategoryMainProduct(map);
			
			int discountPrice; //할인되는 가격
			for(MainProduct dto : list) {
				discountPrice = 0;
				if(dto.getDiscount()>0) {
					discountPrice = (int)(dto.getPrice() * dto.getDiscount()/100);
				}
				dto.setSalePrice(dto.getPrice() - discountPrice);
			}
		} catch (Exception e) {
			log.info("listMainProduct : ", e);
		}
		return list;
	}
	
	//카테고리별 작품 조회
	@Override
	public List<MainProduct> listCategoryProduct(Map<String, Object> map) {
       List<MainProduct> list = null;
		
		try {
			list = mapper.listCategoryProduct(map);
			
			int discountPrice; //할인되는 가격
			for(MainProduct dto : list) {
				discountPrice = 0;
				if(dto.getDiscount()>0) {
					discountPrice = (int)(dto.getPrice() * dto.getDiscount()/100);
				}
				dto.setSalePrice(dto.getPrice() - discountPrice);
			}
		} catch (Exception e) {
			log.info("listCategoryProduct : ", e);
		}
		return list;
	}

	//인기작품 순 작품 조회 메인 초화면
	@Override
	public List<MainProduct> listPopularMainProduct(Map<String, Object> map) {
		List<MainProduct> list = null;
		try {
			list = mapper.listPopularMainProduct(map);
			
			int discountPrice; //할인되는 가격
			for(MainProduct dto : list) {
				discountPrice = 0;
				if(dto.getDiscount()>0) {
					discountPrice = (int)(dto.getPrice() * dto.getDiscount()/100);
				}
				dto.setSalePrice(dto.getPrice() - discountPrice);
			}
		} catch (Exception e) {
			log.info("listPopularMainProduct : " , e);
		}
		return list;
	}
	
	
	//인기작품순 작품 리스트
	@Override
	public List<MainProduct> listPopularProduct(Map<String, Object> map) {
		List<MainProduct> list = null;
		
		try {
			list = mapper.listPopularProduct(map);
			
			int discountPrice; //할인되는 가격
			for(MainProduct dto : list) {
				discountPrice = 0;
				if(dto.getDiscount()>0) {
					discountPrice = (int)(dto.getPrice() * dto.getDiscount()/100);
				}
				dto.setSalePrice(dto.getPrice() - discountPrice);
			}
			
		} catch (Exception e) {
			log.info("listPopularProduct");
		}
		
		return list;
	}
	
	
	//추천작품 순 작품 조회 메인 초화면
	@Override
	public List<MainProduct> listRecommendMainProduct(Map<String, Object> map) {
		 List<MainProduct> list = null;
			
			try {
				list = mapper.listRecommendMainProduct(map);
				
				int discountPrice; //할인되는 가격
				for(MainProduct dto : list) {
					discountPrice = 0;
					if(dto.getDiscount()>0) {
						discountPrice = (int)(dto.getPrice() * dto.getDiscount()/100);
					}
					dto.setSalePrice(dto.getPrice() - discountPrice);
				}
				
			} catch (Exception e) {
				log.info("listRecommendMainProduct");
			}
			
			return list;
	}
	
	//추천작품 순 작품 조회
	@Override
	public List<MainProduct> listRecommendProduct(Map<String, Object> map) {
        List<MainProduct> list = null;
		
		try {
			list = mapper.listRecommendProduct(map);
			
			int discountPrice; //할인되는 가격
			for(MainProduct dto : list) {
				discountPrice = 0;
				if(dto.getDiscount()>0) {
					discountPrice = (int)(dto.getPrice() * dto.getDiscount()/100);
				}
				dto.setSalePrice(dto.getPrice() - discountPrice);
			}
			
		} catch (Exception e) {
			log.info("listRecommendProduct");
		}
		
		return list;
	}
	

	

	@Override
	public MainProduct findById(long productCode) {

		MainProduct dto = null;
		int discountPrice ; //할인되는 가격
		
		try {
			dto = mapper.findById(productCode);
			discountPrice = 0; //할인되는 가격
			if(dto.getDiscount()>0) {
				discountPrice = (int)(dto.getPrice() * (dto.getDiscount()/100));
			}
			dto.setSalePrice(dto.getPrice()-discountPrice);

			
		} catch (Exception e) {
			log.info("findById : " ,e);
		}
		return dto;
	}
	
	


	@Override
	public List<MainProduct> listMainProductFile(long productCode) {
		List<MainProduct> list = null;
		
		try {
			list = mapper.listMainProductFile(productCode);
			
		} catch (Exception e) {
			log.info("listMainProductFile : ", e);
		}

		return list;
	}

	@Override
	public MainProduct findByCategoryId(int categoryCode) {
		MainProduct dto = new MainProduct();
		
		try {
			dto = mapper.findByCategoryId(categoryCode);
		
		} catch (Exception e) {
			log.info("MainProductServiceImpl : ", e  );
		}
		return dto;
	}

	@Override
	public List<MainProduct> listMainProductReview(long productCode) {
		List<MainProduct> list = null;
		
		try {
			list = mapper.listMainProductReview(productCode);
			
		} catch (Exception e) {
			log.info("listMainProductReview : " , e);
		}
		return list;
	}
	
	// 메인 화면 배너 이미지 가져오기
	@Override
	public List<MainProduct> listMainBannerItem() {
		List<MainProduct> list = null;
		try {
			list = mapper.listMainBannerItem();
			System.out.println("######## list" + list);
		} catch (Exception e) {
			log.info("listMainBannerItem : " , e);
		}
		return list;
	}

	//작품 후기글 신고
	@Override
	public void insertReveiwReport(Map<String, Object> params) {
		try {
			mapper.insertReveiwReport(params);
		}catch(Exception e) {
			log.info("insertReveiwReport : ", e  );
		}
	}
	
	//작품 신고
	@Override
	public void insertProductReport(Map<String, Object> params) {
		try {
			mapper.insertProductReport(params);
		}catch(Exception e) {
			log.info("insertProductReport : ", e  );
		}
	
		
	}


}
