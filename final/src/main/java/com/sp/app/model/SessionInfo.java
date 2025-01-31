package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// 세션에 저장할 정보(아이디, 이름, 역할(권한) 등)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SessionInfo {
	private long memberIdx;
	private String userId;
	private String userName;
	private int userLevel;
}
