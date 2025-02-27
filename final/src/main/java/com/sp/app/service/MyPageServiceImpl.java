package com.sp.app.service;

import com.sp.app.mapper.MyPageMapper;
import com.sp.app.model.MyPage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyPageServiceImpl implements MyPageService{
  private final MyPageMapper mapper;
//  private final

  @Override
  public List<MyPage> getOrdersHistory(long memberIdx) {
    List<MyPage> orderList = null;
    try {
      orderList = mapper.getOrdersHistory(memberIdx);
    } catch (Exception e) {
      log.info("주문 내역 리스트 못 가지고옴..",e);
    }

    return orderList;
  }

  @Override
  public List<MyPage> getOrdersHistory1(Map<String, Object> map) {
    List<MyPage> orderList = null;
    try {
      orderList = mapper.getOrdersHistory1(map);
    } catch (Exception e) {
      log.info("주문 내역 리스트 못 가지고옴..",e);
    }

    return orderList;  }

  @Override
  public int dataCount(long memberIdx) {
    return mapper.dataCount(memberIdx);
  }

  @Override
  public MyPage getOrderHistoryDetail(Map<String, Object> map) {
    MyPage dto = null;
    try {
      dto = mapper.getOrderHistoryDetail(map);
    } catch(Exception e) {
      log.info("getOrderHistoryDetail", e);
    }
    return dto;
  }


}
