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
	private String name;
	private String nickName;
	private String birth;
	private int block;
	private String reg_date; // 생성일
	private String lastModified; // 마지막 수정일
	private String last_login; // 마지막 로그인
	private int failCount; // 로그인 실패 횟수
	private String addr; // 주소
	private String addrDetails; // 주소별명

	private String authority; // 권한
	private String oldAuthority; // 이전권한

	private Long addNum;
	private String phone;
	private String addName;
	private String addTitle;
	private String addDetail;
	private int firstAdd;



}
