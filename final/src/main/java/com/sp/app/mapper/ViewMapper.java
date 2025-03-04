package com.sp.app.mapper;

import com.sp.app.model.ViewProduct;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ViewMapper {
    void insertViewProduct(ViewProduct product);
    void updateRecentViewed(ViewProduct product);
    List<ViewProduct> getViewProductHistory(long memberIdx);
    int existsRecentViewed(ViewProduct product);
}
