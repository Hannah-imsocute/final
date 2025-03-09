package com.sp.app.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sp.app.artist.model.ProductManage;
import com.sp.app.common.PaginateUtil;
import com.sp.app.model.Reply;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.ReplyService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/reply/*")
public class ReplyController {
	private final ReplyService service;
	private final PaginateUtil paginateUtil;

	// Session 에서 회원코드 반환
	private static Long getMemberIdx(HttpSession session) {
		SessionInfo member = (SessionInfo) session.getAttribute("member");
		return member.getMemberIdx();
	}
	
	//reply 리스트
	@GetMapping("list")
	public String listReply(
			@RequestParam(name = "community_num") long community_num,
			@RequestParam(name = "pageNo", defaultValue = "1") int current_page,
			Model model,
			HttpServletResponse resp,
			HttpSession session) throws Exception {

		try {
			
			Long memberIdx = getMemberIdx(session);
//			SessionInfo info = (SessionInfo)session.getAttribute("memberIdx");
//			if (info == null) {
//			    throw new IllegalStateException("SessionInfo 객체가 존재하지 않습니다.");
//			}
	
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("community_num", community_num);
			map.put("memberIdx", memberIdx);

			int dataCount = service.dataCount(map);
			
			int size = 5;
			int total_page = paginateUtil.pageCount(dataCount, size);
			
			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<Reply> list = service.listReply(map);

			//페이징 처리할 경우
			String paging = paginateUtil.pagingMethod(current_page, total_page, "listPage");

			 model.addAttribute("list", list);
			 model.addAttribute("pageNo", current_page);
			 model.addAttribute("dataCount", dataCount);
			 model.addAttribute("total_page", total_page);
			 model.addAttribute("paging", paging);
			
		} catch (Exception e) {
			resp.sendError(406);
			log.info("listReply :" ,e);

		}
		
		return "community/listReply";
	}
	
	// AJAX - Map을 JSON으로 변환 반환
	@PostMapping("insert")
	@ResponseBody
	public Map<String, Object> insertReply(
			Reply dto, 
			HttpSession session) throws Exception {
		Map<String, Object> model = new HashMap<>();
	
		String state = "true";
		try {
			
			Long memberIdx = getMemberIdx(session);
	
			dto.setMemberIdx(memberIdx);
			
			System.out.println("Received community_num: " + dto.getCommunity_num());
			service.insertReply(dto);
			
		} catch (Exception e) {
			state = "false";
		}

		model.put("state", state);
		return model;
	}


}
