package com.sp.app.service;

import com.sp.app.mapper.PointMapper;
import com.sp.app.model.MemberPoint;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Transactional(rollbackFor = Exception.class)
@Slf4j

public class PointServiceImpl implements PointService {
    private final PointMapper mapper;


    @Override
    public void insertPointHistory() throws Exception{
        try {
            mapper.insertPointHistory();
        } catch (Exception e) {
            log.info("insertPointHistory", e);
            throw new RuntimeException("포인트 이력 중..");
        }
    }

    @Override
    public void insertPointHistory(MemberPoint point) throws Exception {
        try {
            mapper.insertPointHistory(point);
        } catch (Exception e) {
            log.info("insertPointHistory", e);
            throw new RuntimeException("포인트 이력 등록 중 오류 발생.");
        }
    }

    @Override
    public long getPointSaveNUm() {
        long result = 0;
        try {
            result = mapper.getPointSaveNUm();
        } catch(Exception e) {
            log.info("getPointSaveNUm", e);
            throw new RuntimeException("시퀀스값 못불러옴");
        }
        return result;
    }

    @Override
    public int getUsedPoint() {
        int result = 0;
        try {
           result =  mapper.getUsedPoint();
        } catch(Exception e) {
            log.info("getUsedPoint", e);
        }
        return result;
    }

    @Override
    public int getPointEnabled(long memberIdx) {
        int memberPoint = 0;

        try {
            memberPoint = mapper.getPointEnabled(memberIdx);
        } catch (Exception e) {
            log.info("getLatestUserPoint", e);
            throw new RuntimeException(e);
        }
        return memberPoint;
    }

    @Override
    public void usePoint(MemberPoint param) throws Exception {
        // 1) 포인트 차감
        Map<String, Object> map = new HashMap<>();
        map.put("pointSaveNum", param.getPointSaveNum()); // 어느 적립 레코드에서 차감?
        map.put("memberIdx", param.getMemberIdx());
        map.put("usedAmount", param.getUsedAmount());
        mapper.updatePointValid1(map); // balance -= usedAmount

        // 2) 사용 이력 INSERT
        mapper.insertPointHistory(param);
        // insertPointHistory(param)에서는 param.getPointSaveNum()을 #{pointSaveNum}로,
        // param.getUsedAmount()을 #{usedAmount}로, param.getOrderCode()를 #{orderCode}로 삽입

        // 3) balance가 0이면 enable=1
        mapper.updatePointValid2(map);
    }

    @Override
    public long getPointSaveNum(long memberIdx) {
        long result = 0;
        try {
            result =  mapper.getPointSaveNum(memberIdx);
        } catch(Exception e) {
            log.info("getPointSaveNum", e);
        }
        return result;
    }

    @Transactional
    @Override
    public void insertReviewPoint() throws Exception {
        try {
            mapper.insertReviewPoint();
        } catch(Exception e) {
            log.info("insertReviewPoint", e);
            throw e;
        }
    }

    @Override
    public MemberPoint getUserSaveAmount(long memberIdx) {
        MemberPoint memberPoint = null;

        try {
            memberPoint = mapper.getUserSaveAmount(memberIdx);
        } catch (Exception e) {
            log.info("getUserSaveAmount", e);
            throw new RuntimeException(e);
        }
        return memberPoint;
    }

    @Override
    public void updatePointValid1(Map<String, Object> map) throws Exception {
        try {
            mapper.updatePointValid1(map);
        } catch(Exception e) {
            log.info("updatePointValid1", e);
            throw new RuntimeException("포인트 차감 중 오류..");
        }
    }

    @Override
    public void updatePointValid2(Map<String, Object> map) throws Exception {
        try {
            mapper.updatePointValid2(map);
        } catch(Exception e) {
            log.info("updatePointValid2", e);
            throw new RuntimeException("포인트 enable 설정 중 오류..");
        }
    }




}
