package com.sp.app.admin.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.admin.model.ApplyManage;
import com.sp.app.admin.service.ApplyManageService;
import com.sp.app.common.PaginateUtil;

import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/admin/applyList/*")
public class ApplyManageController {
	private final ApplyManageService service;
	private final PaginateUtil paginateUtil;

	@GetMapping("")
	public String applyManage(Model model) throws Exception {

		return "admin/applyList/applyList";
	}

	// 회원 리스트 : AJAX-Text 응답
	@GetMapping("list")
	public String listMember(@RequestParam(name = "page", defaultValue = "1") int current_page,
			@RequestParam(name = "schType", defaultValue = "userId") String schType,
			@RequestParam(name = "kwd", defaultValue = "") String kwd,
			@RequestParam(name = "agreed", defaultValue = "") String agreed, Model model, HttpServletResponse resp)
			throws Exception {

		try {
			int size = 10;
			int total_page = 0;
			int dataCount = 0;

			kwd = URLDecoder.decode(kwd, "utf-8");

			// 전체 페이지 수
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("agreed", agreed);
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
			if (offset < 0)
				offset = 0;

			map.put("offset", offset);
			map.put("size", size);

			// 멤버 리스트
			List<ApplyManage> list = service.listApply(map);

			String paging = paginateUtil.paging(current_page, total_page, "listMember");

			model.addAttribute("list", list);
			model.addAttribute("page", current_page);
			model.addAttribute("dataCount", dataCount);
			model.addAttribute("size", size);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			model.addAttribute("agreed", agreed);
			model.addAttribute("schType", schType);
			model.addAttribute("kwd", kwd);

		} catch (Exception e) {
			log.info("list", e);

			resp.sendError(406);
			throw e;
		}

		return "admin/applyList/list";
	}

	@PostMapping("updateApply")
	@ResponseBody
	public Map<String, Object> updateApply(
	    @RequestParam(name = "sellerApplyNum") Long sellerApplyNum,
	    @RequestParam(name = "agreed") String agreed, // 승인(0) / 반려(1)
	    @RequestParam(name = "email") String sellerEmail,
	    @RequestParam(name = "name") String sellerName,
	    @RequestParam(name = "rejectionReason", required = false) String rejectionReason
	) {
	    Map<String, Object> map = new HashMap<>();
	    try {
	        map.put("sellerApplyNum", sellerApplyNum);
	        map.put("agreed", agreed);
	        map.put("email", sellerEmail);
	        map.put("name", sellerName);
	        map.put("rejectionReason", rejectionReason);

	        service.updateApply(map);

	        map.put("success", true);
	    } catch (Exception e) {
	        map.put("success", false);
	        map.put("error", e.getMessage());
	    }
	    return map;
	}

	// 컨트롤러에서 데이터 반환
	@GetMapping("getSellerDetails")
	@ResponseBody
	public ApplyManage getSellerDetails(@RequestParam(name = "sellerApplyNum") Long sellerApplyNum,
            @RequestParam(name = "page") String page) {
	    return service.getSellerDetailsBySellerApplyNum(sellerApplyNum);  // 해당 번호의 셀러 정보 반환
	}

}
