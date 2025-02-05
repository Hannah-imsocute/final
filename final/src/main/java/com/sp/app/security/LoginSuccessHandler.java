package com.sp.app.security;


import com.sp.app.model.Member;
import com.sp.app.model.SessionInfo;
import com.sp.app.service.MemberService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import java.io.IOException;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {

  private RequestCache requestCache = new HttpSessionRequestCache(); // 인증 및 권한을 임시로 저장
  private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy(); // 로그인 실패시 적절한 url로 리다이렉트 시킨다.

  private String defaultUrl;

  @Autowired
  private MemberService service;

  @Override
  public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {

    // 로그인 유저 아이디(이메일)
    // System.out.println(authentication.getName());

    try {
      // 로그인 날짜 변경
      service.updateLastLogin(authentication.getName());
    } catch (Exception e) {
    }

    HttpSession session = request.getSession();

    // 로그인 정보
    Member member = service.findByUserEmail(authentication.getName());

    SessionInfo info = SessionInfo.builder()
        .memberIdx(member.getMemberIdx())
        .email(member.getEmail())
        .nickName(member.getNickName())
        .build();

    session.setAttribute("member", info);

    // redirect 설정
    resultRedirectStrategy(request, response, authentication);

  }

  protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
    throws IOException, ServletException {

    SavedRequest savedRequest = requestCache.getRequest(request, response);

    if(savedRequest != null) {
      String targetUrl = savedRequest.getRedirectUrl();
      redirectStrategy.sendRedirect(request, response, targetUrl);

    } else {
      redirectStrategy.sendRedirect(request, response, defaultUrl);
    }
  }

  public void setDefaultUrl(String defaultUrl) {
    this.defaultUrl = defaultUrl;
  }

}
