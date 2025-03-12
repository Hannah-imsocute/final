package com.sp.app.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EventComment {
	private long evtcmm_num;
	private long evt_num;
	private String content;
	private long memberidx;
	private String nickname;
}
