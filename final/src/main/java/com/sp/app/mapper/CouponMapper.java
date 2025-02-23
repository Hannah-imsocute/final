package com.sp.app.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CouponMapper {

    void insertCouponUsed(Map<String, Object> map) throws Exception;
    void deleteCouponUsed(Map<String, Object> map) throws Exception;
    int getCouponCount(long memberIdx);
    

}
