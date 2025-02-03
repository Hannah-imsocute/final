package com.sp.app.interceptor;

import com.sp.app.model.SessionInfo;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

/*
  * HandlerInterceptor 인터페이스
    - 컨트롤러가 요청하기 전과 후에 반복적인 기능을 수행 할 수 있도록 하기 위한 인터페이스
    - 다수의 인터셉터가 설 정 된 경우 (a, b, c 인터셉터가 설정된경우)
      1) a 의 preHandle(),  b 의 preHandle(), c 의 preHandle() 실행
      2) 컨트롤러의 handleRequest() 메소드 실행
      3) c 의 postHandle(),  b 의 postHandle(), a 의 postHandle() 실행
      4) 뷰 객체의 render() 메소드 실행
      5) c 의 afterCompletion(),  b 의 afterCompletion(), a 의 afterCompletion() 실행
    - 로그인 검사, 응답 시간 계산, 이벤트기간 만료등에서 이용하면 편리
*/

@Slf4j
public class LoginCheckInterceptor implements HandlerInterceptor {
	/*
	 - 클라이언트 요청이 컨트롤러에 도착하기 전에 호출
	 - false를 리턴하면 HandlerInterceptor 또는 컨트롤러를 실행하지 않고 요청 종료
	 */
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		boolean result = true;

		try {
			HttpSession session = req.getSession();
			SessionInfo info = (SessionInfo)session.getAttribute("member");
			String cp = req.getContextPath();
			String uri = req.getRequestURI();
			String queryString = req.getQueryString();

			if (info == null) {
				result = false;

				if (isAjaxRequest(req)) {
					resp.sendError(401);
				} else {
					if (uri.indexOf(cp) == 0) {
						uri = uri.substring(cp.length());
					}
					
					if (queryString != null) {
						uri += "?" + queryString;
					}

					session.setAttribute("preLoginURI", uri);
					resp.sendRedirect(cp + "/member/login");
				}
			} else {
				if(uri.indexOf("admin") != -1 && info.getUserState() < 51) {
					result = false;
					resp.sendRedirect(cp + "/member/noAuthorized");
				}
			}
		} catch (Exception e) {
			log.info("pre: " + e.toString());
		}

		return result;
	}

	/*
	   - 컨트롤러가 요청을 처리 한 후에 호출
	   - 컨트롤러 실행 중 예외가 발생하면 실행 하지 않음
	 */
	@Override
	public void postHandle(HttpServletRequest req, HttpServletResponse resp, Object handler, ModelAndView modelAndView)
			throws Exception {
	}

	/*
	   - 클라이언트 요청을 처리한 뒤, 즉 뷰를 통해 클라이언트에 응답을 전송한 뒤에 실행
	   - 컨트롤러 처리 중 또는 뷰를 생성하는 과정에 예외가 발생해도 실행
	 */
	@Override
	public void afterCompletion(HttpServletRequest req, HttpServletResponse resp, Object handler, Exception ex)
			throws Exception {
	}

	// AJAX 요청인지를 확인하기 위해 작성한 메소드
	private boolean isAjaxRequest(HttpServletRequest req) {
		String header = req.getHeader("AJAX");
		return header != null && header.equals("true");
	}

}
