package com.sp.app.security;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.sp.app.model.Member;
import com.sp.app.service.MemberService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginFailureHandler implements AuthenticationFailureHandler {
  @Autowired
  private MemberService memberService;

  private String defaultFailureUrl;

  @Override
  public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                      AuthenticationException exception) throws IOException, ServletException {

    String email = request.getParameter("email");

    String errorMsg = "이메일 또는 패스워드가 일치하지 않습니다.";
    try {
      if (exception instanceof BadCredentialsException) {
        // 패스워드가 일치하지 않을 때 던지는 예외

        int cnt = memberService.checkFailureCount(email);
        if(cnt <= 4) {
          memberService.updateFailureCount(email);
        }

        if(cnt == 4) {
          // 계정 비활성화
          Map<String, Object> map = new HashMap<>();
          map.put("enabled", 0);
          map.put("email", email);
          memberService.updateMemberEnabled(map);

          // 비활성화 상태 저장
          Member dto = new Member();
          dto.setMemberIdx(memberService.getMemberIdx(email));
          dto.setReg_date(email);
          dto.setBlock(1);
//          dto.setMemo("패스워드 5회 이상 실패");
          memberService.insertMemberStatus(dto);
        }

        errorMsg = "이메일 또는 패스워드가 일치하지 않습니다.";
      } else if (exception instanceof InternalAuthenticationServiceException) {

        // 존재하지 않는 아이디 일때 던지는 예외
        errorMsg = "이메일 또는 패스워드가 일치하지 않습니다.";
      } else if (exception instanceof DisabledException) {

        // 인증 거부 - 계정 비활성화(enabled=0)
        errorMsg = "계정이 비활성화되었습니다. 관리자에게 문의하세요.";
      }
    } catch (Exception e) {
      log.info("LoginFailureHandler : " + errorMsg, e);
    }
    response.sendRedirect(defaultFailureUrl);
  }

  public void setDefaultFailureUrl(String defaultFailureUrl) {
    this.defaultFailureUrl = defaultFailureUrl;
  }
}
