package com.sp.app.config;

import com.sp.app.interceptor.LoginCheckInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class SpringMvcConfiguration implements WebMvcConfigurer {

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		List<String> excludePaths = new ArrayList<>();
		excludePaths.add("/");
		excludePaths.add("/test/*");
		excludePaths.add("/mypage/*");
		excludePaths.add("/dist/**");
		excludePaths.add("/member/login");
		excludePaths.add("/cart/*");
		excludePaths.add("/product/*");
		excludePaths.add("/member/logout");
		excludePaths.add("/member/account");
		excludePaths.add("/member/userIdCheck");
		excludePaths.add("/member/complete");
		excludePaths.add("/member/pwdFind");
		excludePaths.add("/products/**");
		excludePaths.add("/search/**");
		excludePaths.add("/display/**");
		excludePaths.add("/review/list");
		excludePaths.add("/qna/list");
		excludePaths.add("/uploads/products/**");
		excludePaths.add("/uploads/specials/**");
		excludePaths.add("/uploads/image/**");
		excludePaths.add("/uploads/jumbo/**");
		excludePaths.add("/uploads/review/**");
		excludePaths.add("/uploads/qna/**");

		registry.addInterceptor(new LoginCheckInterceptor()).excludePathPatterns(excludePaths);
	}

}
