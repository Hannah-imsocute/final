package com.sp.app.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sp.app.model.MyPage;

@Mapper
public interface MyPageMapper {

  // 주문 내역 불러오기
  List<MyPage> getOrdersHistory(long memberIdx);
  int dataCount();
}
