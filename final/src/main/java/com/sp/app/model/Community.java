
package com.sp.app.model;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;


@Getter
@Setter
@NoArgsConstructor
public class Community {
	private long community_num;
	private long memberIdx;
	private String brandName;
	private String content; //
	private String created_po; //글올린 날짜
	private String update_po; //글 수정한 날짜
	
	//커뮤니티 이미지
	private long image_num;
	private String saveFileName;
	private String original_FileName;
	private String uploadDate;
	private List<MultipartFile> images;
	
	//좋아요
	private String liked_at; //좋아요 한 날짜 

	//커뮤니티 댓글
	private long reply_num;
	private String replyContent;
	private String replyCreated;
	private String replyUpdated;
	private long parent_comment_num;
	private int blind;
	
	//커뮤니티 댓글 좋아요
	private String Replyliked_at; // 댓글좋아요한 날짜
	
	
	
	//커뮤니티 댓글 좋아요
	
}