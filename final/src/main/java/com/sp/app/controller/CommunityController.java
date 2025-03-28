package com.sp.app.controller;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.PaginateUtil;
import com.sp.app.common.StorageService;
import com.sp.app.model.Community;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.CommunityService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/community/*")
public class CommunityController {
	private final CommunityService service;
	private final PaginateUtil paginateUtil;


	@GetMapping("list")
	public String list(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "all") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd, Model model, HttpServletRequest req)
			throws Exception {

		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			kwd = URLDecoder.decode(kwd, "utf-8");

			Map<String, Object> map = new HashMap<>();
			map.put("schType", schType);
			map.put("kwd", kwd);

			dataCount = service.dataCount(map);
			total_page = paginateUtil.pageCount(dataCount, size);

			current_page = Math.min(current_page, total_page);

			int offset = (current_page - 1) * size;

			if (offset < 0)
				offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			List<Community> list = service.listCommunity(map);

			String cp = req.getContextPath();
			String query = "page=" + current_page;
			String listUrl = cp + "/community/list";
			String articleUrl = cp + "/community/article";

			if (!kwd.isBlank()) {
				String qs = "schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8");

				listUrl += "?" + qs;
				query += "&" + qs;

			}

			String paging = paginateUtil.paging(current_page, total_page, listUrl);

			model.addAttribute("list", list);

			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("page", current_page);
			model.addAttribute("total_page", total_page);
			model.addAttribute("articleUrl", articleUrl);
			model.addAttribute("paging", paging);

			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			model.addAttribute("query", query);

		} catch (Exception e) {
			log.info("list : ", e);
		}

		return "community/list";
	}

	// 커뮤니티 게시글 상세보기
	@GetMapping("detail/{community_num}")
	public String article(@PathVariable("community_num") long community_num, 
//			@RequestParam(name = "page") String page,
//			@RequestParam(name = "schType", defaultValue = "all") String schType,
//			@RequestParam(name = "kwd", defaultValue = "") String kwd, 
			Model model,
			HttpSession session)
			throws Exception {

//			String query = "page=" + page;

		try {
//				kwd = URLDecoder.decode(kwd, "utf-8");
//				if(! kwd.isBlank()) { 
//					query += "&schType=" + schType + "&kwd=" + URLEncoder.encode(kwd, "utf-8"); 
//					}
			  
			  //조회수 service.updateHitCount(num);
			  
			  
			  //게시글 가져오기
			Community dto = Objects.requireNonNull(service.findById(community_num));
			  
			  //dto.setContent(myUtil.htmlSymbols(dto.getContent())); //스마트에디터 사용할때는 쓰면안됨
//				dto.setUserName(myUtil.nameMasking(dto.getUserName()));
			  
			model.addAttribute("dto", dto); 

			
//			  model.addAttribute("query",query); 
//			  model.addAttribute("page",page);

	
		} catch (NullPointerException e) {
		} catch (Exception e) {
			log.info("article : ", e);
		}
		return "community/detail";
		// return "redirect:/community/list?" + query";
	}

	@GetMapping("write")
	public String writeForm(Model model) throws Exception {
		try {
			model.addAttribute("mode", "write");
		} catch (Exception e) {
			log.info("writeForm : ", e);
		}
		return "community/write";
	}

	@PostMapping("write")
	public String writeSubmit(Community dto, HttpServletRequest request, HttpSession session, Model model)
			throws Exception {

		Long memberIdx = getMemberIdx(session);
		dto.setMemberIdx(memberIdx);

//    	dto.setMemberIdx(2); // 테스트소스

		// 제품(작품) 정보를 DB에 저장하는 신규 메서드
		service.insertCommunity(dto);
//        service.insertCommunityImage(dto, uploadPath);
		// 등록한 작품 리스트 조회

		String contextPath = request.getContextPath();
		return "redirect:" + contextPath + "/community/list";

	}

	// Session 에서 회원코드 반환
	private static Long getMemberIdx(HttpSession session) {
		SessionInfo member = (SessionInfo) session.getAttribute("member");
		return member.getMemberIdx();
	}
	
	
	


}
