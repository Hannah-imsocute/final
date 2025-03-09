package com.sp.app.service;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.sp.app.model.Community;
import com.sp.app.model.Reply;
import com.sp.app.model.SessionInfo;



public interface ReplyService {

	public void insertReply(Reply dto) throws Exception;
	public int dataCount(Map<String, Object> map) throws Exception;
	public List<Reply> listReply(Map<String, Object> map) throws Exception;

}
