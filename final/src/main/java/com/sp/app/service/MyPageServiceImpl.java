package com.sp.app.service;

import com.sp.app.mapper.MyPageMapper;
import com.sp.app.model.Order;
import com.sp.app.model.Review;
import com.sp.app.model.myPage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class MyPageServiceImpl implements MyPageService{
  private final MyPageMapper mapper;
//  private final

  @Override
  public List<myPage> getOrdersHistory(long memberIdx) {
    List<myPage> orderList = null;
    try {
      orderList = mapper.getOrdersHistory(memberIdx);
    } catch (Exception e) {
      log.info("주문 내역 리스트 못 가지고옴..",e);
    }

    return orderList;
  }


}
