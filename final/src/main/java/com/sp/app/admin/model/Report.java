package com.sp.app.admin.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Report {
	private long report_code;
	private long memberIdx;
	private long targetNum;
	private long categoryNum;
	private String reason;
	private String report_date;
}
