package com.sp.app.service;


import com.sp.app.model.myPage;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface MyPageService {

  List<myPage> getOrdersHistory(long memberIdx);
  void insertReview(Map<String, Object> param) throws SQLException;



}
