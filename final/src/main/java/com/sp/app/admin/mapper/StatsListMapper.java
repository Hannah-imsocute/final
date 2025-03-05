package com.sp.app.admin.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface StatsListMapper {

	public List<Map<String, Object>> listAgeSection();
}
