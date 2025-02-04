package com.sp.app.model;

import lombok.*;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Member {
	private long memberIdx;
	private String email;
	private String password;
	private String nickName;
	private String birth;
	private int block;
	private String reg_date; // 생성일
	private String lastModified; // 마지막 수정일
	private String last_login; // 마지막 로그인
	private int failCount; // 로그인 실패 횟수
	private String addr; // 주소
	private String addrDetails; // 주소별명
	private int userState; //

	private Long addNum;
	private String name;
	private String phone;
	private String addName;
	private String addTitle;
	private String addDetail;
	private int firstAdd;


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
