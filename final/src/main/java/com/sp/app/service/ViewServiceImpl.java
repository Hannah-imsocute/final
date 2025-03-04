package com.sp.app.service;

import com.sp.app.mapper.ViewMapper;
import com.sp.app.model.ViewProduct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ViewServiceImpl implements ViewService{
    private final ViewMapper mapper;

    public void insertOrUpdateRecentViewed(ViewProduct product) {
        int count = mapper.existsRecentViewed(product);
        if (count > 0) {
            mapper.updateRecentViewed(product);
        } else {
            mapper.insertViewProduct(product);
        }
    }

    @Override
    public List<ViewProduct> getViewProductHistory(long memberIdx) {
        return mapper.getViewProductHistory(memberIdx);
    }
}
