package com.sp.app.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface CouponMapper {

    void insertCouponUsed(Map<String, Object> map) throws Exception;
    void deleteCouponUsed(Map<String, Object> map) throws Exception;
}
