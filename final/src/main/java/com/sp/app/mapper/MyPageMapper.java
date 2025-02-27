package com.sp.app.mapper;

import com.sp.app.model.MyPage;
import com.sp.app.model.OrderItem;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MyPageMapper {

  // 주문 내역 불러오기
  List<MyPage> getOrdersHistory(long memberIdx);
  List<MyPage> getOrdersHistory1(Map<String, Object> map);
  int dataCount(long memberIdx);
  MyPage getOrderHistoryDetail(Map<String, Object> map);

}
