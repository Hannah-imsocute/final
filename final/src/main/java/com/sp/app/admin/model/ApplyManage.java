package com.sp.app.admin.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class ApplyManage {
	private long sellerApplyNum;
	private String name;
	private String email;
	private String phone;
	private String brandName;
	private String brandIntro;
	private String introPeice;
	private String forExtra;
	private String agreed;
}
