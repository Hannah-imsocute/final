package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/member/*")
public class MemberController {
	private final MemberService service;

	// login 폼은 GET으로 처리하며,
	// login 실패시 loginFailureHandler 에서 /member/login 으로 설정
	//     하여 POST로 다시 이 주소로 이동하므로 GET과 POST를 모두 처리하도록 주소를 매핑
	@RequestMapping(value = "login", method = {RequestMethod.GET, RequestMethod.POST})
	public String loginForm(@RequestParam(name = "login_error", required = false) String login_error,
													Model model) {
		
		if(login_error != null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
		}
		
		return "member/login";
	}

	@GetMapping("account")
	public String memberForm(Model model) {
		model.addAttribute("mode", "account");

		return "member/member";
	}


	@PostMapping("account")
	public String memberSubmit(Member dto,
														 final RedirectAttributes reAttr,
														 Model model,
														 HttpServletRequest req) {

		try {
			service.insertMember(dto);

			StringBuilder sb = new StringBuilder();
			sb.append(dto.getNickName() + "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");

			// 리다이렉트된 페이지에 값 넘기기
			reAttr.addFlashAttribute("message", sb.toString());
			reAttr.addFlashAttribute("title", "회원 가입");

			return "redirect:/member/complete";

		} catch (DuplicateKeyException e) {
			// 기본키 중복에 의한 제약 조건 위반
			model.addAttribute("mode", "account");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
		} catch (DataIntegrityViolationException e) {
			// 데이터형식 오류, 참조키, NOT NULL 등의 제약조건 위반
			model.addAttribute("mode", "account");
			model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
		} catch (Exception e) {
			model.addAttribute("mode", "account");
			model.addAttribute("message", "회원가입이 실패했습니다.");
		}

		return "member/member";
	}


	@GetMapping("complete")
	public String complete(@ModelAttribute("message") String message) throws Exception {

		if (message == null || message.isBlank()) { // F5를 누른 경우
			return "redirect:/";
		}

		return "member/complete";
	}

	@ResponseBody
	@PostMapping("userIdCheck")
	public Map<String, ?> idCheck(@RequestParam(name = "email") String email) throws Exception {
		// ID 중복 검사
		Map<String, Object> model = new HashMap<>();

		String p = "false";
		try {
			Member dto = service.findByUserEmail(email);
			if (dto == null) {
				p = "true";
			}
		} catch (Exception e) {
		}

		model.put("passed", p);

		return model;
	}

	@GetMapping("pwd")
	public String pwdForm(@RequestParam(name = "dropout", required = false) String dropout,
												Model model) {

		if (dropout == null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}

		return "member/pwd";
	}

	@PostMapping("pwd")
	public String pwdSubmit(@RequestParam(name = "pwd") String pwd,
													@RequestParam(name = "mode") String mode,
													final RedirectAttributes reAttr,
													Model model,
													HttpSession session) {

		SessionInfo info = (SessionInfo) session.getAttribute("member");

		try {
			Member dto = Objects.requireNonNull(service.findByUserEmail(info.getEmail()));

			boolean bPwd = service.isPasswordCheck(info.getEmail(), pwd);

			if (! bPwd) {
				model.addAttribute("mode", mode);
				model.addAttribute("message", "패스워드가 일치하지 않습니다.");

				return "member/pwd";
			}

			if (mode.equals("dropout")) {
				// 게시판 테이블등 자료 삭제

				// 회원탈퇴 처리
				/*
				  Map<String, Object> map = new HashMap<>();
				  map.put("memberIdx", info.getMemberIdx());
				  map.put("userId", info.getUserId());
				 */

				// 세션 정보 삭제
				session.removeAttribute("member");
				session.invalidate();

				StringBuilder sb = new StringBuilder();
				sb.append(dto.getNickName() + "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
				sb.append("메인화면으로 이동 하시기 바랍니다.<br>");

				reAttr.addFlashAttribute("title", "회원 탈퇴");
				reAttr.addFlashAttribute("message", sb.toString());

				return "redirect:/member/complete";
			}

			model.addAttribute("dto", dto);
			model.addAttribute("mode", "update");

			// 회원정보수정폼
			return "member/member";

		} catch (NullPointerException e) {
			session.invalidate();
		} catch (Exception e) {
		}

		return "redirect:/";
	}

	@PostMapping("update")
	public String updateSubmit(Member dto,
														 final RedirectAttributes reAttr,
														 Model model) {

		StringBuilder sb = new StringBuilder();
		try {
			service.updateMember(dto);

			sb.append(dto.getNickName() + "님의 회원정보가 정상적으로 변경되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		} catch (Exception e) {
			sb.append(dto.getNickName() + "님의 회원정보 변경이 실패했습니다.<br>");
			sb.append("잠시후 다시 변경 하시기 바랍니다.<br>");
		}

		reAttr.addFlashAttribute("title", "회원 정보 수정");
		reAttr.addFlashAttribute("message", sb.toString());

		return "redirect:/member/complete";
	}

	// 패스워드 찾기
	@GetMapping("pwdFind")
	public String pwdFindForm(HttpSession session) throws Exception {
		SessionInfo info = (SessionInfo)session.getAttribute("member");

		if(info != null) {
			return "redirect:/";
		}

		return "member/pwdFind";
	}

	@PostMapping("pwdFind")
	public String pwdFindSubmit(@RequestParam(name = "email") String email,
															RedirectAttributes reAttr,
															Model model) throws Exception {

		try {
			Member dto = service.findByUserEmail(email);
			if(dto == null || dto.getEmail() == null || dto.getBlock() == 1) {
				model.addAttribute("message", "등록된 아이디가 아닙니다.");

				return "member/pwdFind";
			}

			service.generatePwd(dto);

			StringBuilder sb = new StringBuilder();
			sb.append("회원님의 이메일로 임시패스워드를 전송했습니다.<br>");
			sb.append("로그인 후 패스워드를 변경하시기 바랍니다.<br>");

			reAttr.addFlashAttribute("title", "패스워드 찾기");
			reAttr.addFlashAttribute("message", sb.toString());

			return "redirect:/member/complete";

		} catch (Exception e) {
			model.addAttribute("message", "이메일 전송이 실패했습니다.");
		}

		return "member/pwdFind";
	}

	@GetMapping("updatePwd")
	public String updatePwdForm() throws Exception{
		return "member/updatePwd";
	}

	@PostMapping("updatePwd")
	public String updatePwdSubmit(
			@RequestParam(name = "pwd") String pwd,
			Model model,
			HttpSession session) throws Exception{

		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			Member dto = new Member();
			dto.setEmail(info.getEmail());
			dto.setPassword(pwd);

			service.updatePassword(dto);
		} catch (RuntimeException e) {
			model.addAttribute("message", "변경할 패스워드가 기존 패스워드와 일치합니다.");
			return "member/updatePwd";
		} catch (Exception e) {
		}

		return "redirect:/";
	}

	@GetMapping("noAuthorized")
	public String noAuthorized(Model model) {
		return "member/noAuthorized";
	}

	@GetMapping("expired")
	public String expired() throws Exception {
		// 세션이 익스파이어드(만료) 된 경우
		return "member/expired";
	}
}

