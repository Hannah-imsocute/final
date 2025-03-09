
package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
public class Reply {
	//커뮤니티 댓글
	private long reply_num;
	private long memberIdx;
	private String nickName;
	private long community_num;
	private String content;
	private String created;
	private String updated;
	private long parent_comment_num;
	private int blind;
	private boolean deletePermit;

	
}