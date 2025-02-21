package com.sp.app.admin.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Winners {
	
	private long evtcmm_num;
	private long evt_num;
	
	private String content;
	
	private long memberIdx;
	private String nickname;
	private String email;
}
