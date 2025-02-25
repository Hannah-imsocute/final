package com.sp.app.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sp.app.mapper.MyPageMapper;
import com.sp.app.model.MyPage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

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


}
