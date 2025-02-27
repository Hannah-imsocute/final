package com.sp.app.service;


import com.sp.app.model.MemberPoint;

import java.util.List;
import java.util.Map;

public interface PointService {
    void insertPointHistory() throws Exception; // 포인트 사용 이력 등록
    void insertPointHistory(MemberPoint point) throws Exception; // 파라미터 추가
    long getPointSaveNUm();
    int getUsedPoint(); // 사용금액 반환
    MemberPoint getUserSaveAmount(long memberIdx); // 포인트 누적 기록 가지고오기
    void updatePointValid1(Map<String, Object> map) throws Exception; // 사용 포인트만큼 차감
    void updatePointValid2(Map<String, Object> map) throws Exception; // 포인트 enable 설정

    int getPointEnabled(long memberIdx);

    void usePoint(MemberPoint param) throws Exception;
    long getPointSaveNum(long memberIdx);
    void insertReviewPoint(MemberPoint point) throws Exception; // 포인트 적립

    List<MemberPoint> getUserSaveAmount1(long memberIdx); // 포인트 적립 리스트

    int dataCount(long memberIdx);

    int getSaveAmount(long memberIdx); // 포인트누적금액





}

