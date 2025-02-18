package com.sp.app.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface ProductDetailMapper {

	public void insertProductReport(Map<String, Object> params);


}
