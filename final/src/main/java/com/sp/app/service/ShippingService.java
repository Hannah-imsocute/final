package com.sp.app.service;

import com.sp.app.model.ShippingInfo;

import java.util.List;

public interface ShippingService {

    List<ShippingInfo> getShippingInfo(Long memberIdx) throws Exception;
}
