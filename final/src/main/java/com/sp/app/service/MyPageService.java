package com.sp.app.service;


import com.sp.app.model.myPage;

import java.util.List;

public interface MyPageService {

  List<myPage> getOrdersHistory(long memberIdx);

}
