package com.sp.app.mapper;

import com.sp.app.model.Ask;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface AskMapper {
    void insertAsk(Ask ask) throws SQLException;
    List<Ask> getAskList(Map<String, Object> map) throws Exception;
    int dataCount(long memberIdx);

}
