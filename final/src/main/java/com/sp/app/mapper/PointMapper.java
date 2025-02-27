package com.sp.app.mapper;

import com.sp.app.model.MemberPoint;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface PointMapper {

    void insertPointHistory() throws Exception; // 포인트 사용 이력 등록
    void insertPointHistory(MemberPoint point) throws Exception; // 파라미터 추가
    void updatePointValid1(Map<String, Object> map) throws Exception; // 사용 포인트만큼 차감
    void updatePointValid2(Map<String, Object> map) throws Exception; // 포인트 enable 설정

    int getPointEnabled(long memberIdx); // 사용가능한 포인트 금액

    int getUsedPoint(); // 사용금액 반환
    MemberPoint getUserSaveAmount(long memberIdx); // 포인트 누적 기록 가지고오기

    long getPointSaveNum(long memberIdx);

    long getPointSaveNUm();

    void insertReviewPoint(MemberPoint point) throws SQLException; // 포인트 적립

    List<MemberPoint> getUserSaveAmount1(long memberIdx);

    int dataCount(long memberIdx);

    int getSaveAmount(long memberIdx); // 포인트누적금액
}
