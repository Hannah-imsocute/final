package com.sp.app.service;


import java.util.List;

import com.sp.app.model.MyPage;

public interface MyPageService {

  List<MyPage> getOrdersHistory(long memberIdx);

}
