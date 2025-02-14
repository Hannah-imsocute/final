package com.sp.app.mapper;

import java.sql.SQLException;

public interface ClientEventMapper {
	
	// 데이터 카운트 = 유효한것 한정
	public int dataCount() throws SQLException;
	
}
