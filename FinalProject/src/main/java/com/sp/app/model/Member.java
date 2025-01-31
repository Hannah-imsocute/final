package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Member {
	private long memberIdx;
	private String userId;
	private String userPwd;
	private String userName;
	private int userLevel;
	private int enabled;
	private String register_date;
	private String modify_date;
	private String last_login;
	private String email;
	private String email1;
	private String email2;
	private int receiveEmail;
	private String tel;
	private String tel1;
	private String tel2;
	private String tel3;
	private String birth;
	private String zip;
	private String addr1;
	private String addr2;
	private String ipAddr;
}
