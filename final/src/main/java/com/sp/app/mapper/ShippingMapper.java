package com.sp.app.mapper;

import com.sp.app.model.ShippingInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ShippingMapper {

/* 주소 검색 */
List<ShippingInfo> getShippingInfo(Long memberIdx) throws Exception;

/* 주소 선택*/
void insertShippingAddress(ShippingInfo shippingInfo) throws Exception;

/* 배송사 주소 등록 */
void insertPackage(ShippingInfo shippingInfo) throws Exception;


}
