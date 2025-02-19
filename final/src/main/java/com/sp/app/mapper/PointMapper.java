package com.sp.app.mapper;

import com.sp.app.model.MemberPoint;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PointMapper {

    MemberPoint getLatestUserPoint();
}
