package com.sp.app.mapper;

import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface OrderManageMapper {
            public int orderCount(Map<String,Object> map);
}
