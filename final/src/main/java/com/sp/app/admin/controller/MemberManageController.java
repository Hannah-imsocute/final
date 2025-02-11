 package com.sp.app.admin.controller;

import java.net.URLDecoder;
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

import com.sp.app.admin.model.MemberManage;
import com.sp.app.admin.service.MemberManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/authList/*")
public class MemberManageController {
	private final MemberManageService service;
	private final PaginateUtil paginateUtil;
	
	@GetMapping("")
	public String memberManage(Model model) throws Exception {

		return "admin/authList/authList";
	}

	// 회원 리스트 : AJAX-Text 응답
	@GetMapping("list")
	public String listMember(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "userId") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "role", defaultValue = "1") int  role,
			@RequestParam(name = "non", defaultValue = "0") int  non,
			@RequestParam(name = "block", defaultValue = "") String block,
			Model model,
			HttpServletResponse resp) throws Exception {

		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			kwd = URLDecoder.decode(kwd, "utf-8");

			// 전체 페이지 수
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("role", role);
			map.put("non", non);
			map.put("block", block);
			map.put("schType", schType);
			map.put("kwd", kwd);

			dataCount = service.dataCount(map);
			if (dataCount != 0) {
				total_page = paginateUtil.pageCount(dataCount, size);
			}

			// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
			current_page = Math.min(current_page, total_page);

			// 리스트에 출력할 데이터를 가져오기
			int offset = (current_page - 1) * size;
			if(offset < 0) offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			// 멤버 리스트
			List<MemberManage> list = service.listMember(map);

			String paging = paginateUtil.paging(current_page, total_page, "listMember");

			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("role", role);
			model.addAttribute("non", non);
			model.addAttribute("block", block);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);
			
		} catch (Exception e) {
			log.info("list", e);
			
			resp.sendError(406);
			throw e;
		}

		return "admin/authList/list";
	}
	
	// 회원상세 정보 : AJAX-Text 응답
	@GetMapping("profile")
	public String detaileMember(@RequestParam(name = "memberIdx") Long memberIdx, 
			@RequestParam(name = "page") String page,
			Model model,
			HttpServletResponse resp) throws Exception {
		
		try {
			MemberManage dto = Objects.requireNonNull(service.findById(memberIdx));
			MemberManage memberStatus = service.findByStatus(memberIdx);
			List<MemberManage> listStatus = service.listMemberStatus(memberIdx);

			model.addAttribute("dto", dto);
			model.addAttribute("memberStatus", memberStatus);
			model.addAttribute("listStatus", listStatus);
			model.addAttribute("page", page);
			
		} catch (NullPointerException e) {
			resp.sendError(410);
			throw e;
		} catch (Exception e) {
			resp.sendError(406);
			throw e;
		}

		return "admin/authList/profile";
	}

	// 회원 정보 변경 : AJAX-JSON 응답
	@ResponseBody
	@PostMapping("updateMember")
	public Map<String, ?> updateMember(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "true";
		try {
			// 회원 정보 변경
			service.updateMember(paramMap);
		} catch (Exception e) {
			state = "false";
		}

		model.put("state", state);
		return model;
	}

	// 회원 상태 변경 : AJAX-JSON 응답
	@ResponseBody
	@PostMapping("updateMemberStatus")
	public Map<String, ?> updateMemberStatus(MemberManage dto) throws Exception {
		Map<String, Object> model = new HashMap<>();

		String state = "true";
		try {
			// 회원 활성/비활성 변경
			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", dto.getMemberIdx());
			if (dto.getStatusCode() == 0) {
				map.put("enabled", 1);
			} else {
				map.put("enabled", 0);
			}
			service.updateMemberEnabled(map);

			// 회원 상태 변경 사항 저장
			service.insertMemberStatus(dto);

			if (dto.getStatusCode() == 0) {
				// 회원 패스워드 실패횟수 초기화
				service.updateFailureCountReset(dto.getMemberIdx());
			}
		} catch (Exception e) {
			state = "false";
		}

		model.put("state", state);
		return model;
	}
	
	// 회원 연령대별 인원수 : AJAX-JSON 응답
	@ResponseBody
	@GetMapping("memberAgeSection")
	public Map<String, ?> memberAgeSection() throws Exception {
		Map<String, Object> model = new HashMap<String, Object>();

		// 연령대별 인원수
		List<Map<String, Object>> list = service.listAgeSection();

		model.put("list", list);

		return model;
	}	
}
