package com.sp.app.artist.mapper;

import com.sp.app.artist.model.OrderManage;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface OrderManageMapper {
            public int orderCount(Map<String,Object> map);
    public List<OrderManage> listOrder(Map<String, Object> map);

}
