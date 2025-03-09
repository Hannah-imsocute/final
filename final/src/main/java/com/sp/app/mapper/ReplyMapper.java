package com.sp.app.mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.sp.app.model.Reply;
@Mapper
public interface ReplyMapper {
	
	//댓글
	public void insertReply(Reply dto) throws SQLException;
	public int dataCount(Map<String, Object> map) throws SQLException;
	public List<Reply> listReply(Map<String, Object> map) throws SQLException;

}
