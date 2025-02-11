package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class MemberManage {
	private long memberIdx;
	private String email;
	private String password;
	private String nickname;
	private int block;
	private String reg_date;
	private String lastModified;
	private String lastLogin;
	private int failCount;
	private String email1;
	private String email2;
	private int receiveEmail;
	private String phone;
	private String phone1;
	private String phone2;
	private String phone3;
	private String dob;
	private int age;
	private String addName;
	private String addTitle;
	private String addDetail;
	private String firstAdd;
	
	private String authority;
	private String oldAuthority;
	private String rt_value;	
	
	private long num;
	private int statusCode;
	private String memo;
	private String registerId;
}
