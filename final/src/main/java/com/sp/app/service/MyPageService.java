package com.sp.app.service;


import com.sp.app.model.MyPage;
import com.sp.app.model.Payment;

import java.util.List;
import java.util.Map;

public interface MyPageService {

  List<MyPage> getOrdersHistory(long memberIdx);
  List<MyPage> getOrdersHistory1(Map<String, Object> map);
  int dataCount(long memberIdx);
  MyPage getOrderHistoryDetail(Map<String, Object> map);
  Payment getPaymentHistory(Payment payment);

}
