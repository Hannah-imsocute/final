package com.sp.app.service;

import com.sp.app.mapper.ShippingMapper;
import com.sp.app.model.ShippingInfo;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j

public class ShippingServiceImpl implements ShippingService{
    private final ShippingMapper mapper;

    @Override
    public List<ShippingInfo> getShippingInfo(Long memberIdx) throws Exception {
        List<ShippingInfo> list = null;
        try {
            list = mapper.getShippingInfo(memberIdx);
            if(list == null) {
                log.info("배송지 목록을 못 가직오옴{}", list);
                return List.of();
            }
        } catch(Exception e) {
            log.info("회원 주소지 목록 가져오기 실패", e);
        }
        return list;
    }
}
