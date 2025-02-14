package com.sp.app.mapper;

import com.sp.app.model.ShippingInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ShippingMapper {

List<ShippingInfo> getShippingInfo(Long memberIdx) throws Exception;

void insertShippingAddress(ShippingInfo shippingInfo) throws Exception;


}
