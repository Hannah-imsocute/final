package com.sp.app.service;

import com.sp.app.mapper.CouponMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class CouponServiceImpl implements CouponService {

    private final CouponMapper mapper;


    @Transactional(rollbackFor = Exception.class)
    @Override
    public void insertCouponUsed(Map<String, Object> map) throws Exception {
        try {
            mapper.insertCouponUsed(map);
        } catch (Exception e) {
            log.info("insertCouponUsed", e);
            throw new RuntimeException(e);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleteCouponUsed(Map<String, Object> map) throws Exception {
        try {
            mapper.deleteCouponUsed(map);
        } catch (Exception e) {
            log.error("deleteCouponUsed", e);
            throw new RuntimeException(e);
        }
    }

}
