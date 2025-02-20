package com.sp.app.service;

import java.util.Map;

public interface CouponService {

    void insertCouponUsed(Map<String, Object> map) throws Exception;
    void deleteCouponUsed(Map<String, Object> map) throws Exception;
}
