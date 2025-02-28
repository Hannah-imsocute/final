package com.sp.app.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.StorageService;
import com.sp.app.model.Member;
import com.sp.app.model.Seller;
import com.sp.app.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member/register")
@RequiredArgsConstructor
public class RegisterController {
	
	private final MemberService service;
	private final String path = "/uploads/sellerAcc";
	private final StorageService storage;
	
	@GetMapping
	public String registerForm() {
		return "member/register";
	}
	
	@PostMapping("idcheck")
	@ResponseBody
	public Map<String, Object> idcheck(@RequestParam(name = "email")String email){
		Map<String, Object> model = new HashMap<>();
		model.put("state","false");
		try {
			Member dto = Objects.requireNonNull(service.findByUserEmail(email));
		} catch (NullPointerException e) {
			model.put("state","true");
		} catch (Exception e) {
		}
		return model;
	}
	
	@PostMapping()
	public String handleSubmit(@ModelAttribute Member member) {
		try {
			// email, domain name, nickname, password, phone, birth
			member.setEmail(member.getEmail()+ "@" + member.getDomain());
			service.insertMember(member);
			return "redirect:/";
		} catch (Exception e) {
		}
		return "redirect:/";
	}
	
	
	@GetMapping("/seller")
	public String handleForm() {
		return "member/sellerRegister";
	}

	@PostMapping("/seller")
	public String handleSubmit(@ModelAttribute() Seller seller ) {
		// email, password, nickname, birth, accNumber, bank, bankStatement
		
		try {
			// 파일저장부터하기 
			String savefilename = storage.uploadFileToServer(seller.getBankStatement(), path);
			seller.setAccImage(savefilename);
			
			// 차례대로 insert 하기 
			service.insertAllOfSeller(seller);
		} catch (Exception e) {
		}
		
		return "redirect:/";
	}
	
	@PostMapping("/sellercheck")
	@ResponseBody
	public Map<String, Object> checkEmail(@RequestParam(name = "email") String email){
		Map<String, Object> map = new HashMap<>();
		try {
			boolean isvalid = service.checkOfSeller(email);
			map.put("state", isvalid);
		} catch (Exception e) {
		}
		return map;
	}
}
