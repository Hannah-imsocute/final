package com.sp.app.security;

public class NumericRoleGranted {
	public final static int INACTIVE = 0; // 비회원
	public final static int USER = 1;	// 일반회원
	public final static int AUTHOR = 77;	// 작가
	public final static int ADMIN = 99;	// 관리자
	
	public static int getUserLevel(String authority) {
		try {
			switch (authority) {
			case "USER" : return USER;
			case "AUTHOR" : return AUTHOR;
			case "ADMIN" : return ADMIN;
			}
		} catch (Exception e) {
		}
		
		return 0;
	}
}
