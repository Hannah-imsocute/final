package com.sp.app.mapper;

import com.sp.app.model.myPage;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface MyPageMapper {

  // 주문 내역 불러오기
  List<myPage> getOrdersHistory(long memberIdx);
  int dataCount();
}
