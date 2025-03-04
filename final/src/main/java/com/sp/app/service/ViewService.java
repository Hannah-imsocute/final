package com.sp.app.service;


import com.sp.app.model.ViewProduct;

import java.util.List;

public interface ViewService {
    void insertOrUpdateRecentViewed(ViewProduct product);
    List<ViewProduct> getViewProductHistory(long memberIdx);
}
