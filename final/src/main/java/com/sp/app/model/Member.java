package com.sp.app.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Member {

	private long member_Id;
	private String email;
	private String password;
	private String nickName;
	private String birth;
	private String phone;
	private String reg_date;
	private String lastModified;
	private String addr; // 주소
	private String addrDetails; // 주소별명
	private int userState; // 사용자:1 작가:2 관리자:3
	private int block;


/*
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
 */
}
