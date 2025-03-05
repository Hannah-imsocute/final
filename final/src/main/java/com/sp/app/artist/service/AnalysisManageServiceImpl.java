package com.sp.app.artist.service;

import com.sp.app.artist.mapper.TotalManageMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
@RequiredArgsConstructor
@Slf4j
public class AnalysisManageServiceImpl implements AnalysisManageService{
            public final TotalManageMapper mapper;

    @Override
    public Map<String, Object> todayProduct(long memberIdx) {
        Map<String,Object> resultMap =null;
        try {
            resultMap= mapper.todayProduct(memberIdx);
        }catch (Exception e){
            log.info("todayProduct:",e );
        }

        return resultMap;
    }

    @Override
    public Map<String, Object> thisMonthProduct(long memberIdx) {
        Map<String,Object> resultMap =null;
        try {
            resultMap = mapper.thisMonthProduct(memberIdx);
        }catch (Exception e){
            log.info("thisMonthProduct :",e);
        }
        return resultMap;
    }

    @Override
    public Map<String, Object> previousMonthProduct(long memberIdx) {
        Map<String,Object> resultMap =null;
        try {
            resultMap = mapper.previousMonthProduct(memberIdx);
        }catch (Exception e){
            log.info("previousMonthProduct : ",e);
        }
        return resultMap;
    }

    @Override
    public List<Map<String, Object>> dayTotalMoney(Map<String, Object> map) {
        List<Map<String,Object>>list = null;
        try {
            list = mapper.dayTotalMoney(map);
        }catch (Exception e){
            log.info("dayTotalMoney : ",e);
        }



        return list;
    }

    @Override
    public List<Map<String, Object>> dayTotalMoney2(Map<String, Object> map) {
        List<Map<String,Object>>list = null;


        try {
            list = mapper.dayTotalMoney2(map);
        }catch (Exception e){
            log.info("dayTotalMoney2 : ",e);
        }
        return list;
    }

    @Override
    public List<Map<String, Object>> monthTotalMoney(Map<String, Object> map) {
        List<Map<String,Object>>list = null;
        try {
            list = mapper.monthTotalMoney(map);
        }catch (Exception e){
            log.info("monthTotalMoney : ",e);
        }

        return list;
    }

    @Override
    public List<Map<String, Object>> monthTotalMoney2(Map<String, Object> map) {
        List<Map<String,Object>>list = null;
        try {
            list = mapper.monthTotalMoney2(map);
        }catch (Exception e){
            log.info("monthTotalMoney2 : ",e);
        }

        return list;
    }

    @Override
    public Map<String, Object> dayOfWeekTotalCount(Map<String, Object> map) {
        Map<String,Object> resultmap=  null;
        try {
            resultmap = mapper.dayOfWeekTotalCount(map);
        }catch (Exception e){
            log.info("dayOfWeekTotalCount : ",e);
        }

        return resultmap;
    }
}
